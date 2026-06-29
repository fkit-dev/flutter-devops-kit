import 'dart:io';

import '../core/command.dart';
import '../core/command_category.dart';
import '../generators/yaml_generator.dart';
import '../services/bootstrap_service.dart';
import '../services/logger_service.dart';
import '../services/prompt_service.dart';
import '../wizard/init_wizard.dart';

class InitCommand extends Command {
  @override
  String get name => 'init';

  @override
  String get description => 'Initialize FKIT configuration';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit init';

  @override
  List<String> get examples => const [
        'fkit init',
      ];

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    final configFile = File('fkit.yaml');

    if (configFile.existsSync()) {
      LoggerService.warning(
        'Existing FKIT configuration detected.',
      );

      try {
        final content = await configFile.readAsString();

        final match = RegExp(
          r'project_name:\s*(.*)',
        ).firstMatch(content);

        final projectName = match?.group(1)?.trim();

        if (projectName != null && projectName.isNotEmpty) {
          LoggerService.info(
            'Project: $projectName',
          );
        }
      } catch (_) {}

      LoggerService.blank();

      final replace = PromptService.confirm(
        'Do you want to replace it?',
      );

      if (!replace) {
        LoggerService.blank();

        LoggerService.warning(
          'Initialization cancelled.',
        );

        LoggerService.blank();

        return;
      }

      LoggerService.blank();
    }

    final config = await InitWizard().start();

    await configFile.writeAsString(
      YamlGenerator.generate(config),
    );

    if (PromptService.confirm(
      'Configure project now?',
      defaultValue: true,
    )) {
      await BootstrapService().setup(config);
    }

    LoggerService.blank();

    LoggerService.success(
      'fkit.yaml created successfully.',
    );

    LoggerService.blank();
  }
}
