import 'dart:io';

import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import 'template_renderer.dart';

mixin GeneratorMixin {
  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Future<bool> shouldGenerate(FileSystemEntity entity, {bool overwrite = false}) async {
    if (!entity.existsSync()) return true;
    if (overwrite) return true;

    return PromptService.confirm('${entity.path} already exists. Overwrite?', defaultValue: false);
  }

  Future<void> ensureDirectory(Directory directory) async {
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
      LoggerService.success('Created ${directory.path}');
    }
  }

  Future<void> writeFile({required File file, required String content, bool overwrite = false}) async {
    if (file.existsSync() && !overwrite) {
      LoggerService.info('Skipped ${file.path}');
      return;
    }

    await file.parent.create(recursive: true);

    await file.writeAsString(content);

    LoggerService.success('Generated ${file.path}');
  }

  String path(String featurePath, String relative) {
    return '$featurePath/$relative';
  }

  Future<void> generateTemplate(
      {required String templateRoot,
      required String template,
      required String output,
      required Map<String, String> variables,
      bool overwrite = false}) async {
    final content = await TemplateRenderer.render(templateRoot: templateRoot, template: template, variables: variables);
    await writeFile(file: File(output), content: content, overwrite: overwrite);
  }

  String resolveVariables(String value, Map<String, String> variables) {
    return TemplateRenderer.renderString(value, variables);
  }

  Future<bool> confirmOverwrite(String description) async {
    return PromptService.confirm('$description already exists. Overwrite?', defaultValue: false);
  }
}
