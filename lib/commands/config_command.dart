import '../core/command.dart';
import '../core/command_category.dart';
import '../models/init_config.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';
import '../utils/platform_utils.dart';

/// Displays the current FKIT project configuration.
///
/// Loads and presents the configuration defined for the current project.
class ConfigCommand extends Command {
  @override
  String get name => 'config';

  @override
  String get description => 'Print loaded FKIT configuration';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit config';

  @override
  List<String> get examples => const ['fkit config'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    final config = await ConfigService.load();

    LoggerService.section('Loaded Project Configuration');
    LoggerService.info('FKIT Version      : ${config.version}');
    LoggerService.info('Project           : ${config.projectName}');
    LoggerService.info('Use FVM           : ${config.useFvm}');
    LoggerService.info('Main Entry        : ${config.mainEntry}');
    LoggerService.info('Feature Path      : ${config.featureDir}');
    LoggerService.info('Template          : ${config.defaultTemplate}');
    LoggerService.blank();

    LoggerService.section('Platforms');
    LoggerService.info('Android           : ${config.android}');
    LoggerService.info('iOS               : ${config.ios}');
    LoggerService.info('Web               : ${config.web}');
    LoggerService.blank();

    LoggerService.section('Flavoring');
    LoggerService.info('Enabled           : ${config.flavoringEnabled}');
    LoggerService.info('Default Target    : ${config.defaultFlavor}');
    LoggerService.info('Targets           : ${config.flavors.join(', ')}');
    LoggerService.blank();

    _printEnvironment(config);
    _printFirebase(config);
    _printLocalization(config);
  }

  void _printEnvironment(InitConfig config) {
    LoggerService.section('Environment');
    LoggerService.info('Enabled           : ${config.environment.enabled}');

    if (!config.environment.enabled) {
      LoggerService.blank();
      return;
    }

    for (final target in config.flavors) {
      final environment = config.environment.configurationFor(target);
      LoggerService.info('$target : ${environment?.file ?? 'Not configured'}');
    }
    LoggerService.blank();
  }

  void _printFirebase(InitConfig config) {
    LoggerService.section('Firebase');
    LoggerService.info('Enabled           : ${config.firebase.enabled}');

    if (!config.firebase.enabled) {
      LoggerService.blank();
      return;
    }

    LoggerService.info('Tester Group      : ${config.firebase.testerGroup}');
    LoggerService.blank();

    for (final target in config.flavors) {
      LoggerService.command(target);
      final firebase = config.firebase.configurationFor(target);

      if (firebase == null) {
        LoggerService.info('Firebase         : Not configured');
        LoggerService.blank();
        continue;
      }

      for (final entry in firebase.entries()) {
        if (!PlatformUtils.isEnabled(config, entry.name)) continue;

        LoggerService.info('${entry.name.toUpperCase()} App ID    : ${entry.platform.appId}');
        LoggerService.info('${entry.name.toUpperCase()} Options   : ${entry.platform.options}');
      }
      LoggerService.blank();
    }
  }

  void _printLocalization(InitConfig config) {
    LoggerService.section('Localization');
    LoggerService.info('Enabled           : ${config.localization.enabled}');

    if (!config.localization.enabled) {
      LoggerService.blank();
      return;
    }

    LoggerService.info('ARB Directory     : ${config.localization.arbDir}');
    LoggerService.info('Template ARB      : ${config.localization.templateArb}');
    LoggerService.info('Output Directory  : ${config.localization.outputDir}');
    LoggerService.info('Output File       : ${config.localization.outputFile}');
    LoggerService.info('Default Locale    : ${config.localization.defaultLocale}');
    LoggerService.info('Locales           : ${config.localization.locales.join(', ')}');
    LoggerService.blank();
  }
}
