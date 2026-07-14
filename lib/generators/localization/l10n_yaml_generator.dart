import 'dart:io';

import '../../models/init_config.dart';
import '../../services/logger_service.dart';

/// Generates the `l10n.yaml` configuration file for Flutter localization.
class L10nYamlGenerator {
  const L10nYamlGenerator._();

  /// Generates the localization configuration file using the provided project
  /// configuration.
  static Future<void> generate(
    InitConfig config,
  ) async {
    if (!config.localization.enabled) {
      return;
    }

    final file = File('l10n.yaml');

    final content = _buildContent(config);

    if (file.existsSync()) {
      final existing = await file.readAsString();

      if (existing.trim() == content.trim()) {
        LoggerService.info('l10n.yaml already up to date.');
        return;
      }
    }

    await file.writeAsString(content);

    LoggerService.success('Generated l10n.yaml');
  }

  static String _buildContent(
    InitConfig config,
  ) {
    final buffer = StringBuffer()
      ..writeln('arb-dir: ${config.localization.arbDir}')
      ..writeln('template-arb-file: app_${config.localization.defaultLocale}.arb')
      ..writeln('output-localization-file: ${config.localization.outputFile}')
      ..writeln('output-dir: ${config.localization.outputDir}');

    return buffer.toString();
  }
}
