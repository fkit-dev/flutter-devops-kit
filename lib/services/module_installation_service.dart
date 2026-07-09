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

class ModuleInstallationService {
  const ModuleInstallationService();

  Future<ModuleInstallationResult> install({
    required InitConfig config,
    required TemplateDefinition template,
    required String moduleName,
    PubspecService? pubspecService,
    bool syncDependencies = true,
    bool postGenerate = true,
  }) async {
    final module = await const ModuleService().load(
      template: template.name,
      module: moduleName,
    );

    final options = await const ModuleOptionResolver().resolve(
      module,
    );

    final context = ModuleContext(
      config: config,
      template: template,
      module: module,
      options: options,
    );

    final generated = await const ModuleGenerator().generate(
      context,
    );

    if (!generated) {
      return ModuleInstallationResult(
        moduleName: moduleName,
        installed: false,
        requiresBuildRunner: module.requiresBuildRunner,
      );
    }

    final pubspec = pubspecService ?? PubspecService();

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

    if (postGenerate) {
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
