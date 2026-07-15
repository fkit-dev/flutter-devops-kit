import '../core/command.dart';
import '../core/command_category.dart';
import '../models/config/config_section.dart';
import '../services/config/config_display_service.dart';
import '../services/config/config_service.dart';
import '../services/config/config_update_service.dart';
import '../services/logger_service.dart';

/// Displays or updates FKIT project configuration.
class ConfigCommand extends Command {
  @override
  String get name => 'config';

  @override
  String get description => 'Display or update FKIT configuration';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit config [section]';

  @override
  List<String> get examples =>
      const ['fkit config', 'fkit config firebase', 'fkit config environment', 'fkit config localization', 'fkit config flavors'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    final config = await ConfigService.load();

    if (args.isEmpty) {
      const ConfigDisplayService().display(config);
      return;
    }

    final section = ConfigSection.fromName(args.first);

    if (section == null) {
      LoggerService.error('Unknown configuration section "${args.first}".');
      LoggerService.blank();
      LoggerService.info('Available sections:');
      for (final value in ConfigSection.values) {
        LoggerService.info('  • ${value.name}');
      }
      return;
    }

    // ConfigUpdateService will be connected here next.
    await const ConfigUpdateService().update(section: section, config: config);
  }
}
