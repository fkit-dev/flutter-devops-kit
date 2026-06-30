import '../core/command.dart';
import '../core/command_category.dart';
import '../generators/core/generator_context.dart';
import '../generators/feature/component_generator.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../services/template_service.dart';

class MakeCommand extends Command {
  @override
  String get name => 'make';

  @override
  String get description => 'Generate a project component';

  @override
  CommandCategory get category => CommandCategory.feature;

  @override
  String get usage => 'fkit make <component> <feature> [name]';

  @override
  List<String> get examples => const [
        'fkit make dto auth Login',
        'fkit make entity auth Login',
        'fkit make mapper auth Login',
        'fkit make usecase auth Login',
        'fkit make bloc auth',
        'fkit make repository auth',
        'fkit make screen auth',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    if (args.length < 2) {
      LoggerService.error('Usage: $usage');
      return;
    }

    final target = args[0].trim();
    final feature = args[1].trim();
    final resource = args.length > 2 ? args[2].trim() : null;

    final config = await ConfigService.load();
    final template = await TemplateService.load(config.defaultTemplate);

    final context = GeneratorContext(config: config, feature: feature, name: resource, template: template);

    LoggerService.section('Generating $target: ${resource ?? feature}');

    final generator = const ComponentGenerator();

    if (template.components.containsKey(target)) {
      await generator.generate(context: context, component: target);
    } else if (template.groups.containsKey(target)) {
      for (final item in template.groups[target]!.components) {
        await generator.generate(context: context, component: item);
      }
    } else {
      LoggerService.error('Unknown component "$target".');

      LoggerService.blank();

      LoggerService.info('Supported components:');
      LoggerService.blank();

      for (final entry in template.components.entries) {
        LoggerService.info('${entry.key.padRight(25)}${entry.value.description}');
      }

      LoggerService.blank();

      LoggerService.blank();
      LoggerService.info('Supported groups:');
      LoggerService.blank();

      for (final entry in template.groups.entries) {
        LoggerService.info('${entry.key.padRight(25)}${entry.value.description}');
      }

      return;
    }

    await FlutterService(config).buildRunner();

    LoggerService.blank();
    if (template.groups.containsKey(target)) {
      LoggerService.success('Group "$target" generated successfully.');
    } else {
      LoggerService.success('$target generated successfully.');
    }
    LoggerService.blank();
  }
}
