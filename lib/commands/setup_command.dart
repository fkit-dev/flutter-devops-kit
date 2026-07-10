import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';
import '../services/project_setup_service.dart';
import '../services/template_service.dart';

/// Sets up the current Flutter project using its FKIT configuration.
///
/// Applies the project setup tasks defined by the selected template.
class SetupCommand extends Command {
  @override
  String get name => 'setup';

  @override
  String get description => 'Setup the project using the selected template';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit setup';

  @override
  List<String> get examples => const [
        'fkit setup',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    final config = await ConfigService.load();

    final template = await TemplateService.load(
      config.defaultTemplate,
    );

    LoggerService.section('FKIT Project Setup');

    LoggerService.info(
      'Template: ${template.displayName}',
    );

    LoggerService.blank();

    await const ProjectSetupService().setup(
      config: config,
      template: template,
    );

    LoggerService.blank();

    LoggerService.success(
      'Project setup completed successfully.',
    );

    LoggerService.blank();
  }
}
