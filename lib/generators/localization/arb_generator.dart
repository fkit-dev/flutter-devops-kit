import 'dart:convert';
import 'dart:io';

import '../../models/init_config.dart';
import '../../services/logger_service.dart';

class ArbGenerator {
  const ArbGenerator._();

  static Future<void> generate(
    InitConfig config,
  ) async {
    if (!config.localizationEnabled) {
      return;
    }

    final directory = Directory(config.arbDir);

    if (!directory.existsSync()) {
      await directory.create(
        recursive: true,
      );

      LoggerService.success(
        'Created ${config.arbDir}',
      );
    }

    for (final locale in config.locales) {
      await _createOrUpdateArb(
        config,
        locale,
      );
    }
  }

  static Future<void> _createOrUpdateArb(
    InitConfig config,
    String locale,
  ) async {
    final file = File(
      '${config.arbDir}/app_$locale.arb',
    );

    if (!file.existsSync()) {
      final json = locale == config.defaultLocale
          ? _defaultTemplate(locale)
          : _localeTemplate(locale);

      await file.writeAsString(
        const JsonEncoder.withIndent(
          '  ',
        ).convert(json),
      );

      LoggerService.success(
        'Generated app_$locale.arb',
      );

      return;
    }

    if (locale != config.defaultLocale) {
      LoggerService.info(
        'app_$locale.arb already exists.',
      );
      return;
    }

    await _mergeDefaultKeys(file, locale);
  }

  static Future<void> _mergeDefaultKeys(
    File file,
    String locale,
  ) async {
    final existing =
        jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    final defaults = _defaultTemplate(locale);

    var updated = false;

    for (final entry in defaults.entries) {
      if (!existing.containsKey(entry.key)) {
        existing[entry.key] = entry.value;
        updated = true;
      }
    }

    if (!updated) {
      LoggerService.info(
        '${file.path.split('/').last} already up to date.',
      );
      return;
    }

    await file.writeAsString(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(existing),
    );

    LoggerService.success(
      'Updated ${file.path.split('/').last}',
    );
  }

  static Map<String, dynamic> _defaultTemplate(
    String locale,
  ) {
    return {
      '@@locale': locale,
      'hello': 'Hello',
      '@hello': {
        'description': 'Greeting message',
      },
      'welcome': 'Welcome',
      '@welcome': {
        'description': 'Welcome message',
      },
    };
  }

  static Map<String, dynamic> _localeTemplate(
    String locale,
  ) {
    return {
      '@@locale': locale,
    };
  }
}
