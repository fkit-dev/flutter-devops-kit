import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/feature_generation_service.dart';
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

    final feature = args.first.trim();

    final config = await ConfigService.load();
    final template = await TemplateService.load(
      config.defaultTemplate,
    );

    LoggerService.section('Generating feature: $feature');

    final generated = await const FeatureGenerationService().generate(
      config: config,
      template: template,
      feature: feature,
    );

    if (!generated) {
      LoggerService.blank();
      LoggerService.info(
        'Feature "$feature" generation cancelled.',
      );
      LoggerService.blank();
      return;
    }

    LoggerService.blank();
    LoggerService.success(
      'Feature "$feature" generated successfully.',
    );
    LoggerService.blank();
  }
}
