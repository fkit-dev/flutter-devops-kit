import 'dart:io';

import '../models/init_config.dart';
import '../services/logger_service.dart';

class L10nYamlGenerator {
  const L10nYamlGenerator._();

  static Future<void> generate(
    InitConfig config,
  ) async {
    if (!config.localizationEnabled) {
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
      ..writeln('arb-dir: ${config.arbDir}')
      ..writeln('template-arb-file: app_${config.defaultLocale}.arb')
      ..writeln('output-localization-file: ${config.outputFile}')
      ..writeln('output-dir: ${config.outputDir}');

    return buffer.toString();
  }
}
