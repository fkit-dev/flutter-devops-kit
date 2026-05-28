import 'dart:io';

import '../core/command.dart';
import '../generators/yaml_generator.dart';
import '../services/logger_service.dart';
import '../services/prompt_service.dart';

class InitCommand extends Command {
  @override
  String get name => 'init';

  @override
  String get description => 'Initialize FKIT configuration';

  @override
  Future<void> run(List<String> args) async {
    final configFile = File('fkit.yaml');

    if (configFile.existsSync()) {
      LoggerService.warning('Existing FKIT configuration detected.');

      try {
        final existingContent = await configFile.readAsString();

        final projectMatch = RegExp(r'project_name:\s*(.*)').firstMatch(existingContent);

        final projectName = projectMatch?.group(1)?.trim();

        if (projectName != null && projectName.isNotEmpty) {
          LoggerService.info('Project: $projectName');
        }
      } catch (_) {}

      LoggerService.blank();

      final shouldReplace = PromptService.confirm('Do you want to replace it?');

      if (!shouldReplace) {
        LoggerService.blank();

        LoggerService.warning('Initialization cancelled.');

        LoggerService.blank();

        return;
      }

      LoggerService.blank();
    }

    LoggerService.section('FKIT Project Initialization');

    final projectName = PromptService.ask('Project name');

    final useFvm = PromptService.confirm('Use FVM?');

    final android = PromptService.confirm('Enable Android?');

    final ios = PromptService.confirm('Enable iOS?');

    final web = PromptService.confirm('Enable Web?');

    final flavoringEnabled = PromptService.confirm('Does project use flavors?');

    late final List<String> flavors;

    late final String defaultFlavor;

    if (flavoringEnabled) {
      final flavorsInput = PromptService.ask('Flavors (comma separated)');

      flavors = flavorsInput.split(',').map((e) => e.trim()).toList();

      defaultFlavor = PromptService.ask('Default flavor');
    } else {
      flavors = ['main'];

      defaultFlavor = 'main';
    }

    final flavorConfigs = <String, Map<String, dynamic>>{};

    for (final flavor in flavors) {
      LoggerService.blank();

      LoggerService.command(flavor);

      final env = PromptService.ask('Env file path');

      final appId = PromptService.ask('Firebase App Distribution ID');

      final androidFirebase = PromptService.ask('Android Firebase options path');

      final iosFirebase = PromptService.ask('iOS Firebase options path');

      final webFirebase = PromptService.ask('Web Firebase options path');

      flavorConfigs[flavor] = {
        'env': env,

        'appId': appId,

        'firebaseOptions': {'android': androidFirebase, 'ios': iosFirebase, 'web': webFirebase},
      };
    }

    final yaml = YamlGenerator.generate(
      projectName: projectName,
      useFvm: useFvm,
      android: android,
      ios: ios,
      web: web,
      flavoringEnabled: flavoringEnabled,
      defaultFlavor: defaultFlavor,
      flavors: flavorConfigs,
    );

    final file = File('fkit.yaml');

    await file.writeAsString(yaml);

    LoggerService.blank();

    LoggerService.success('fkit.yaml created successfully.');

    LoggerService.blank();
  }
}
