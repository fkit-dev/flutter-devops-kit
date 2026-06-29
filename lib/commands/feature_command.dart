import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/generator_service.dart';
import '../services/logger_service.dart';
import '../services/template_service.dart';

class FeatureCommand extends Command {
  @override
  String get name => 'feat';

  @override
  String get description => 'Generate feature module';

  @override
  CommandCategory get category => CommandCategory.feature;

  @override
  String get usage => 'fkit feat <feature_name>';

  @override
  List<String> get examples => const [
        'fkit feat auth',
        'fkit feat profile',
        'fkit feat dashboard',
      ];

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

    final feature = args.first;

    final config = await ConfigService.load();

    LoggerService.section(
      'Generating feature: $feature',
    );

    final template = await TemplateService.loadTemplate(
      config.defaultTemplate,
    );

    await GeneratorService.generateFeature(
      feature: feature,
      templateName: config.defaultTemplate,
      template: template,
    );

    LoggerService.blank();

    LoggerService.success(
      'Feature generated successfully.',
    );

    LoggerService.blank();
  }
}
