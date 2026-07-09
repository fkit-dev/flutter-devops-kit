import 'dart:io';

import '../generators/core/generator_mixin.dart';
import '../models/init_config.dart';
import '../models/template/template_definition.dart';
import '../services/logger_service.dart';
import '../services/prompt_service.dart';

class ProjectBootstrapService with GeneratorMixin {
  const ProjectBootstrapService();

  Future<bool> bootstrap({
    required InitConfig config,
    required TemplateDefinition template,
  }) async {
    final bootstrap = template.setup.bootstrap;

    if (!bootstrap.enabled) {
      LoggerService.info(
        'Project bootstrap is not enabled for template '
        '"${template.name}".',
      );

      return false;
    }

    LoggerService.section('Bootstrapping Application');

    final variables = <String, String>{
      'projectName': config.projectName,
    };

    var generatedAny = false;

    final app = bootstrap.app;

    if (app != null) {
      final generated = await _generateBootstrapFile(
        templateRoot: template.name,
        templatePath: app.template,
        outputPath: app.output,
        variables: variables,
      );

      generatedAny = generatedAny || generated;
    }

    final main = bootstrap.main;

    if (main != null) {
      final generated = await _generateBootstrapFile(
        templateRoot: template.name,
        templatePath: main.template,
        outputPath: main.output,
        variables: variables,
      );

      generatedAny = generatedAny || generated;
    }

    return generatedAny;
  }

  Future<bool> _generateBootstrapFile({
    required String templateRoot,
    required String templatePath,
    required String outputPath,
    required Map<String, String> variables,
  }) async {
    final file = File(outputPath);

    var overwrite = false;

    if (file.existsSync()) {
      overwrite = PromptService.confirm(
        '$outputPath already exists. Overwrite?',
        defaultValue: false,
      );

      if (!overwrite) {
        LoggerService.info(
          'Skipped $outputPath.',
        );

        return false;
      }
    }

    await generateTemplate(
      templateRoot: templateRoot,
      template: templatePath,
      output: outputPath,
      variables: variables,
      overwrite: overwrite,
    );

    return true;
  }
}
