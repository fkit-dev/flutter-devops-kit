import 'dart:io';

import '../../models/init_config.dart';
import '../../services/logger_service.dart';

class LocalizationExtensionGenerator {
  static Future<void> generate(
    InitConfig config,
  ) async {
    if (!config.localizationEnabled) {
      return;
    }

    final directory = Directory(
      'lib/core/extensions',
    );

    if (!directory.existsSync()) {
      await directory.create(
        recursive: true,
      );
    }

    final file = File(
      '${directory.path}/context_localization_extension.dart',
    );

    final import =
        '${config.outputDir.replaceFirst('lib/', '')}/${config.outputFile}';

    await file.writeAsString(
      '''
import 'package:flutter/widgets.dart';
import '../../gen/l10n/$import';

extension LocalizationExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
''',
    );

    LoggerService.success(
      'Generated localization extension.',
    );
  }
}
