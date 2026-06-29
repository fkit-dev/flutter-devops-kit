import 'dart:io';

import '../models/init_config.dart';
import '../services/logger_service.dart';

class LocalizationValidator {
  const LocalizationValidator._();

  static void validate(
    InitConfig config,
  ) {
    if (!config.localizationEnabled) {
      LoggerService.warning(
        'Localization is disabled in fkit.yaml.',
      );
      return;
    }

    _validateArbDirectory(config);
    _validateTemplate(config);
    _validateLocales(config);
    _validateOutputDirectory(config);
    _validateDefaultLocale(config);
    LoggerService.success(
      'Localization configuration validated.',
    );
  }

  static void _validateArbDirectory(
    InitConfig config,
  ) {
    final directory = Directory(
      config.arbDir,
    );

    if (!directory.existsSync()) {
      throw Exception(
        'ARB directory not found: ${config.arbDir}',
      );
    }

    LoggerService.success(
      'ARB directory found.',
    );
  }

  static void _validateTemplate(
    InitConfig config,
  ) {
    final template = File(
      '${config.arbDir}/app_${config.defaultLocale}.arb',
    );

    if (!template.existsSync()) {
      throw Exception(
        'Template ARB not found: ${template.path}',
      );
    }

    LoggerService.success(
      'Template ARB found.',
    );
  }

  static void _validateLocales(
    InitConfig config,
  ) {
    for (final locale in config.locales) {
      final file = File(
        '${config.arbDir}/app_$locale.arb',
      );

      if (!file.existsSync()) {
        throw Exception(
          'Missing locale file: ${file.path}',
        );
      }

      LoggerService.success(
        'Locale "$locale" found.',
      );
    }
  }

  static void _validateOutputDirectory(
    InitConfig config,
  ) {
    final directory = Directory(
      config.outputDir,
    );

    if (!directory.existsSync()) {
      LoggerService.warning(
        'Output directory does not exist yet. '
        'It will be created after flutter gen-l10n.',
      );
    } else {
      LoggerService.success(
        'Output directory found.',
      );
    }
  }

  static void _validateDefaultLocale(
    InitConfig config,
  ) {
    if (!config.locales.contains(
      config.defaultLocale,
    )) {
      throw Exception(
        'Default locale "${config.defaultLocale}" '
        'is not included in supported locales.',
      );
    }

    LoggerService.success(
      'Default locale validated.',
    );
  }
}
