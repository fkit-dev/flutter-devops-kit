import 'dart:io';

import '../models/template_config.dart';
import 'logger_service.dart';
import 'placeholder_service.dart';

class GeneratorService {
  static Future<void> generateFeature({required String feature, required String templateName, required TemplateConfig template}) async {
    final basePath = 'lib/features/$feature';

    for (final folder in template.folders) {
      final fullPath = '$basePath/$folder';

      final dir = Directory(fullPath);

      if (!dir.existsSync()) {
        dir.createSync(recursive: true);

        LoggerService.success('Created: $fullPath');
      }
    }

    for (final file in template.files) {
      final sourcePath =
          '.fkit/templates/'
          '$templateName/files/'
          '${file.source}';

      final sourceFile = File(sourcePath);

      if (!sourceFile.existsSync()) {
        LoggerService.warning(
          'Missing template: '
          '${file.source}',
        );

        continue;
      }

      final templateContent = await sourceFile.readAsString();

      final generatedContent = PlaceholderService.replace(input: templateContent, feature: feature);

      final destination = PlaceholderService.replace(input: file.destination, feature: feature);

      final fullDestination = '$basePath/$destination';

      final outputFile = File(fullDestination);

      outputFile.parent.createSync(recursive: true);

      await outputFile.writeAsString(generatedContent);

      LoggerService.success(
        'Generated: '
        '$fullDestination',
      );
    }
  }
}
