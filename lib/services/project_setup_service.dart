import 'dart:io';

import '../generators/maintainers/app_maintainer.dart';
import '../models/init_config.dart';
import '../models/template/template_definition.dart';
import 'extension_service.dart';
import 'feature_generation_service.dart';
import 'flutter_service.dart';
import 'localization_service.dart';
import 'logger_service.dart';
import 'module_installation_service.dart';
import 'project_bootstrap_service.dart';
import 'pubspec_service.dart';

/// Configures an FKIT project using the selected template.
///
/// Performs project setup tasks based on the provided project configuration
/// and template definition.
class ProjectSetupService {
  /// Creates a project setup service.
  const ProjectSetupService();

  /// Sets up the project using the provided [config] and [template].
  ///
  /// Returns whether the project setup process completed successfully.
  Future<bool> setup({
    required InitConfig config,
    required TemplateDefinition template,
    bool overwrite = false,
    bool runFlutterCommands = true,
  }) async {
    final setup = template.setup;

    if (setup.modules.isEmpty &&
        setup.features.isEmpty &&
        !setup.bootstrap.enabled) {
      LoggerService.warning(
        'No project setup configuration found for template '
        '"${template.name}".',
      );

      return false;
    }

    _validateBootstrapTargets(template);

    final pubspec = PubspecService(runPubGet: runFlutterCommands);

    await _prepareProject(
      config: config,
      runFlutterCommands: runFlutterCommands,
    );

    await _collectTemplateRequirements(
      template: template,
      pubspec: pubspec,
    );

    final moduleRequiresBuildRunner = await _installModules(
      config: config,
      template: template,
      modules: setup.modules,
      pubspec: pubspec,
      overwrite: overwrite,
      defaultsOnly: overwrite,
      runFlutterCommands: runFlutterCommands,
    );

    // Synchronize all collected template and module dependencies once.
    await pubspec.save();

    final featuresGenerated = await _generateFeatures(
      config: config,
      template: template,
      features: setup.features,
      overwrite: overwrite,
      runFlutterCommands: runFlutterCommands,
    );

    await const ProjectBootstrapService().bootstrap(
      config: config,
      template: template,
      overwrite: overwrite,
    );

    if (config.localization.enabled) {
      await _wireLocalization(
        config: config,
        template: template,
      );
    }

    if (runFlutterCommands) {
      await FlutterService(config).postGenerate(
        buildRunner: template.requirements.buildRunner ||
            moduleRequiresBuildRunner ||
            featuresGenerated,
      );
    }

    return true;
  }

  Future<void> _prepareProject({
    required InitConfig config,
    required bool runFlutterCommands,
  }) async {
    LoggerService.section('Preparing Project');

    if (config.localization.enabled) {
      await LocalizationService().generate(
        config: config,
        maintainApp: false,
        runFlutterCommands: runFlutterCommands,
      );
    }

    await ExtensionService().generate();
  }

  Future<void> _collectTemplateRequirements({
    required TemplateDefinition template,
    required PubspecService pubspec,
  }) async {
    final requirements = template.requirements;

    if (requirements.packages.isNotEmpty) {
      await pubspec.ensureDependencies(
        requirements.packages,
      );
    }

    if (requirements.devPackages.isNotEmpty) {
      await pubspec.ensureDevDependencies(
        requirements.devPackages,
      );
    }

    if (requirements.flutterGen) {
      await pubspec.ensureFlutterGenerate();
    }
  }

  Future<bool> _installModules({
    required InitConfig config,
    required TemplateDefinition template,
    required List<String> modules,
    required PubspecService pubspec,
    required bool overwrite,
    required bool defaultsOnly,
    required bool runFlutterCommands,
  }) async {
    var requiresBuildRunner = false;

    if (modules.isEmpty) {
      return requiresBuildRunner;
    }

    LoggerService.section('Installing Modules');

    for (final moduleName in modules) {
      final result = await const ModuleInstallationService().install(
        config: config,
        template: template,
        moduleName: moduleName,
        pubspecService: pubspec,
        syncDependencies: false,
        postGenerate: false,
        overwrite: overwrite,
        defaultsOnly: defaultsOnly,
        runFlutterCommands: runFlutterCommands,
      );

      if (!result.installed) {
        LoggerService.info(
          'Skipped module "$moduleName".',
        );

        continue;
      }

      if (result.requiresBuildRunner) {
        requiresBuildRunner = true;
      }
    }

    return requiresBuildRunner;
  }

  Future<bool> _generateFeatures({
    required InitConfig config,
    required TemplateDefinition template,
    required List<String> features,
    required bool overwrite,
    required bool runFlutterCommands,
  }) async {
    var generatedAny = false;

    if (features.isEmpty) {
      return generatedAny;
    }

    LoggerService.section('Generating Features');

    for (final feature in features) {
      final generated = await const FeatureGenerationService().generate(
        config: config,
        template: template,
        feature: feature,
        postGenerate: false,
        overwrite: overwrite,
        runFlutterCommands: runFlutterCommands,
      );

      if (!generated) {
        LoggerService.info(
          'Skipped feature "$feature".',
        );

        continue;
      }

      generatedAny = true;
    }

    return generatedAny;
  }

  void _validateBootstrapTargets(TemplateDefinition template) {
    final bootstrap = template.setup.bootstrap;
    if (!bootstrap.enabled) return;

    final files = [bootstrap.app, bootstrap.main].whereType();
    for (final file in files) {
      final target = File(file.output);
      if (target.existsSync() &&
          target.statSync().type != FileSystemEntityType.file) {
        throw Exception('Bootstrap target is not a file: ${file.output}');
      }
      final parent = target.parent;
      if (parent.existsSync() &&
          parent.statSync().type != FileSystemEntityType.directory) {
        throw Exception(
            'Bootstrap target parent is not a directory: ${parent.path}');
      }
    }
  }

  Future<void> _wireLocalization({
    required InitConfig config,
    required TemplateDefinition template,
  }) async {
    final app = template.setup.bootstrap.app;
    if (app == null) {
      throw Exception(
        'Cannot enable localization: template "${template.name}" does not '
        'configure a bootstrap App file.',
      );
    }

    if (!File(app.output).existsSync()) {
      throw Exception(
        'Cannot enable localization: configured bootstrap App file is missing '
        'at ${app.output}.',
      );
    }

    await const AppMaintainer().enableLocalization(
      appFilePath: app.output,
      outputDir: config.localization.outputDir,
      outputFile: config.localization.outputFile,
    );
  }
}
