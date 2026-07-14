import 'dart:io';

import '../../models/init_config.dart';
import '../../services/logger_service.dart';

/// Generates localization extension files for FKIT projects.
class LocalizationExtensionGenerator {
  /// Generates localization extensions using the provided configuration.
  static Future<void> generate(
    InitConfig config,
  ) async {
    if (!config.localization.enabled) {
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

    final import = '${config.localization.outputDir.replaceFirst('lib/', '')}/${config.localization.outputFile}';

    await file.writeAsString(
      '''
import 'package:flutter/widgets.dart';
import '../../$import';

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
