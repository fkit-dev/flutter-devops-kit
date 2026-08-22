import '../generators/module/module_context.dart';
import '../generators/module/module_generator.dart';
import '../generators/module/module_option_resolver.dart';
import '../models/init_config.dart';
import '../models/module/module_installation_result.dart';
import '../models/template/template_definition.dart';
import 'flutter_service.dart';
import 'module_integration_service.dart';
import 'module_service.dart';
import 'pubspec_service.dart';

/// Installs FKIT modules into a Flutter project.
///
/// Handles module generation using the provided project configuration,
/// template definition, and installation options.
class ModuleInstallationService {
  /// Creates a module installation service.
  const ModuleInstallationService();

  /// Installs a module using the specified configuration and template.
  ///
  /// The [config] defines the project configuration, [template] describes the
  /// module to generate, and [moduleName] identifies the module being installed.
  ///
  /// An optional [pubspecService] can be provided to manage dependency changes.
  /// When [syncDependencies] is `true`, required dependencies are synchronized.
  /// When [postGenerate] is `true`, post-generation tasks are executed.
  ///
  /// Returns a [ModuleInstallationResult] describing the installation outcome.
  Future<ModuleInstallationResult> install({
    required InitConfig config,
    required TemplateDefinition template,
    required String moduleName,
    PubspecService? pubspecService,
    bool syncDependencies = true,
    bool postGenerate = true,
    bool overwrite = false,
    bool defaultsOnly = false,
    bool runFlutterCommands = true,
  }) async {
    final module = await const ModuleService().load(
      template: template.name,
      module: moduleName,
    );

    final options = await const ModuleOptionResolver().resolveWithDefaults(
      module,
      defaultsOnly: defaultsOnly,
    );

    final context = ModuleContext(
      config: config,
      template: template,
      module: module,
      options: options,
    );

    final generated = await const ModuleGenerator().generate(
      context,
      overwrite: overwrite,
    );

    if (!generated) {
      return ModuleInstallationResult(
        moduleName: moduleName,
        installed: false,
        requiresBuildRunner: module.requiresBuildRunner,
      );
    }

    final pubspec =
        pubspecService ?? PubspecService(runPubGet: runFlutterCommands);

    if (context.enabledPackages.isNotEmpty) {
      await pubspec.ensureDependencies(
        context.enabledPackages,
      );
    }

    if (context.enabledDevPackages.isNotEmpty) {
      await pubspec.ensureDevDependencies(
        context.enabledDevPackages,
      );
    }

    if (syncDependencies) {
      await pubspec.save();
    }

    await const ModuleIntegrationService().integrate(
      context,
    );

    if (postGenerate && runFlutterCommands) {
      await FlutterService(config).postGenerate(
        buildRunner: module.requiresBuildRunner,
      );
    }

    return ModuleInstallationResult(
      moduleName: moduleName,
      installed: true,
      requiresBuildRunner: module.requiresBuildRunner,
    );
  }
}
