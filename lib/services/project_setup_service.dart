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
  }) async {
    final setup = template.setup;

    if (setup.modules.isEmpty && setup.features.isEmpty && !setup.bootstrap.enabled) {
      LoggerService.warning(
        'No project setup configuration found for template '
        '"${template.name}".',
      );

      return false;
    }

    final pubspec = PubspecService();

    await _prepareProject(
      config: config,
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
    );

    // Synchronize all collected template and module dependencies once.
    await pubspec.save();

    final featuresGenerated = await _generateFeatures(
      config: config,
      template: template,
      features: setup.features,
    );

    await const ProjectBootstrapService().bootstrap(
      config: config,
      template: template,
    );

    await FlutterService(config).postGenerate(
      buildRunner: template.requirements.buildRunner || moduleRequiresBuildRunner || featuresGenerated,
    );

    return true;
  }

  Future<void> _prepareProject({
    required InitConfig config,
  }) async {
    LoggerService.section('Preparing Project');

    if (config.localization.enabled) {
      await LocalizationService().generate();
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
}
