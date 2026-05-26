import '../core/command.dart';
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
  Future<void> run(List<String> args) async {
    if (args.isEmpty) {
      LoggerService.error('Usage: fkit feat <feature_name>');

      return;
    }

    final feature = args.first;

    final config = await ConfigService.load();

    final templateName = config.defaultTemplate;

    LoggerService.section('Generating feature: $feature');

    final template = await TemplateService.loadTemplate(templateName);

    await GeneratorService.generateFeature(feature: feature, templateName: templateName, template: template);

    LoggerService.blank();

    LoggerService.success('Feature generated successfully.');

    LoggerService.blank();
  }
}
