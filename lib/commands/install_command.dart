import '../core/command.dart';
import '../core/command_category.dart';
import '../generators/core/generator_context.dart';
import '../generators/maintainers/route_maintainer.dart';
import '../generators/module/module_context.dart';
import '../generators/module/module_generator.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../services/module_service.dart';
import '../services/pubspec_service.dart';
import '../services/template_service.dart';

class InstallCommand extends Command {
  @override
  String get name => 'install';

  @override
  String get description => 'Install a template module';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit install <module>';

  @override
  List<String> get examples => const ['fkit install theme', 'fkit install network', 'fkit install storage'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    if (args.isEmpty) {
      LoggerService.error('Usage: $usage');
      return;
    }

    final moduleName = args.first.trim();
    final config = await ConfigService.load();
    final template = await TemplateService.load(config.defaultTemplate);

    if (!template.modules.containsKey(moduleName)) {
      LoggerService.error('Unknown module "$moduleName".');
      LoggerService.blank();
      LoggerService.info('Available modules:');
      LoggerService.blank();
      for (final entry in template.modules.entries) {
        LoggerService.info('  • ${entry.key.padRight(12)}${entry.value.description}');
      }
      return;
    }

    final module = await const ModuleService().load(template: template.name, module: moduleName);

    final context = ModuleContext(config: config, template: template, module: module);

    LoggerService.section('Installing ${module.displayName}');

    await const ModuleGenerator().generate(context);

    final pubspec = PubspecService();
    if (module.hasPackages) await pubspec.ensureDependencies(module.requirements.packages);
    if (module.hasDevPackages) await pubspec.ensureDevDependencies(module.requirements.devPackages);
    await pubspec.save();

    LoggerService.info('Installed module name: "$moduleName"');

    //TODO: Clean it later
    if (moduleName == 'router') {
      final generatorContext = GeneratorContext(config: config, feature: '', template: template);
      await const RouteMaintainer().maintain(generatorContext);
    }

    await FlutterService(config).postGenerate(buildRunner: module.requiresBuildRunner);

    LoggerService.blank();
    LoggerService.success('${module.displayName} installed successfully.');
    LoggerService.blank();
  }
}
