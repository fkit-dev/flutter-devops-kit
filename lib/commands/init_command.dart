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
    LoggerService.section('FKIT Project Initialization');

    final projectName = PromptService.ask('Project name');

    final useFvm = PromptService.confirm('Use FVM?');

    final android = PromptService.confirm('Enable Android?');

    final ios = PromptService.confirm('Enable iOS?');

    final web = PromptService.confirm('Enable Web?');

    final flavorsInput = PromptService.ask('Flavors (comma separated)');

    final defaultFlavor = PromptService.ask('Default flavor');

    final flavors = flavorsInput.split(',').map((e) => e.trim()).toList();

    final flavorConfigs = <String, Map<String, dynamic>>{};

    for (final flavor in flavors) {
      LoggerService.blank();

      LoggerService.command(flavor);

      final env = PromptService.ask('Env file path');

      final appId = PromptService.ask('Firebase App Distribution ID');

      final firebaseOptions = PromptService.ask('Firebase options file');

      flavorConfigs[flavor] = {'env': env, 'appId': appId, 'firebaseOptions': firebaseOptions};
    }

    final yaml = YamlGenerator.generate(
      projectName: projectName,
      useFvm: useFvm,
      android: android,
      ios: ios,
      web: web,
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
