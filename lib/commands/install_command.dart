import '../core/command.dart';
import '../core/command_args.dart';
import '../core/command_category.dart';
import '../services/config/config_service.dart';
import '../services/logger_service.dart';
import '../services/module_installation_service.dart';
import '../services/template_service.dart';

/// Installs modules into the current FKIT project.
///
/// Handles module generation, dependency configuration, and project
/// integration tasks.
class InstallCommand extends Command {
  @override
  String get name => 'install';

  @override
  String get description => 'Install a template module';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit install <module> [--yes|--force]';

  @override
  List<String> get examples => const [
        'fkit install theme',
        'fkit install network',
        'fkit install router',
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

    final positional = CommandArgs.positional(args);
    if (positional.isEmpty) {
      LoggerService.error('Usage: $usage');
      return;
    }

    final moduleName = positional.first.trim();
    final overwrite = CommandArgs.hasFlag(args, '--yes') ||
        CommandArgs.hasFlag(args, '--force');

    final config = await ConfigService.load();

    final template = await TemplateService.load(
      config.defaultTemplate,
    );

    if (!template.modules.containsKey(moduleName)) {
      LoggerService.error(
        'Unknown module "$moduleName".',
      );

      LoggerService.blank();
      LoggerService.info('Available modules:');
      LoggerService.blank();

      for (final entry in template.modules.entries) {
        LoggerService.info(
          '  • ${entry.key.padRight(12)}'
          '${entry.value.description}',
        );
      }

      return;
    }

    LoggerService.section(
      'Installing $moduleName',
    );

    final result = await const ModuleInstallationService().install(
      config: config,
      template: template,
      moduleName: moduleName,
      overwrite: overwrite,
      defaultsOnly: overwrite,
    );

    if (!result.installed) {
      LoggerService.blank();
      LoggerService.info(
        '$moduleName installation cancelled.',
      );
      LoggerService.blank();
      return;
    }

    LoggerService.blank();

    LoggerService.success(
      '$moduleName installed successfully.',
    );

    LoggerService.blank();
  }
}
