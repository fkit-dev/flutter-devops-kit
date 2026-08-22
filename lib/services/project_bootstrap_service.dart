import 'dart:io';

import '../generators/core/generator_mixin.dart';
import '../models/init_config.dart';
import '../models/template/template_definition.dart';
import '../services/logger_service.dart';
import '../services/prompt_service.dart';

/// Bootstraps a Flutter project using the selected FKIT template.
///
/// Performs template-defined project setup and generation tasks using the
/// provided project configuration.
class ProjectBootstrapService with GeneratorMixin {
  /// Creates a project bootstrap service.
  const ProjectBootstrapService();

  /// Bootstraps the project using the provided [config] and [template].
  ///
  /// Returns `false` when project bootstrapping is disabled for the selected
  /// template. Otherwise, performs the configured bootstrap operations and
  /// returns whether the bootstrap process completed successfully.
  Future<bool> bootstrap({
    required InitConfig config,
    required TemplateDefinition template,
    bool overwrite = false,
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
        overwrite: overwrite,
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
        overwrite: overwrite,
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
    required bool overwrite,
  }) async {
    final file = File(outputPath);

    var shouldOverwrite = overwrite;

    if (file.existsSync() && !shouldOverwrite) {
      shouldOverwrite = PromptService.confirm(
        '$outputPath already exists. Overwrite?',
        defaultValue: false,
      );

      if (!shouldOverwrite) {
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
      overwrite: shouldOverwrite,
    );

    return true;
  }
}
