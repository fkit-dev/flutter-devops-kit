import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';
import '../utils/platform_utils.dart';

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

    LoggerService.info('Project          : ${config.projectName}');
    LoggerService.info('Use FVM          : ${config.useFvm}');
    LoggerService.info('Main Entry       : ${config.mainEntry}');
    LoggerService.info('Flavoring        : ${config.flavoringEnabled}');
    LoggerService.info('Default Flavor   : ${config.defaultFlavor}');
    LoggerService.info('Tester Group     : ${config.testerGroup}');
    LoggerService.info('Feature Path     : ${config.featureDir}');
    LoggerService.info('Template         : ${config.defaultTemplate}');
    LoggerService.blank();

    LoggerService.section('Platforms');
    LoggerService.info('Android          : ${config.android}');
    LoggerService.info('iOS              : ${config.ios}');
    LoggerService.info('Web              : ${config.web}');
    LoggerService.blank();

    LoggerService.section('Localization');
    LoggerService.info('Enabled          : ${config.localizationEnabled}');
    LoggerService.info('ARB Directory    : ${config.arbDir}');
    LoggerService.info('Output Directory : ${config.outputDir}');
    LoggerService.info('Output File      : ${config.outputFile}');
    LoggerService.info('Default Locale   : ${config.defaultLocale}');
    LoggerService.info('Locales          : ${config.locales.join(', ')}');
    LoggerService.blank();
    LoggerService.section('Flavors');

    for (final entry in config.flavors.entries) {
      final flavor = entry.value;
      LoggerService.command(entry.key);
      LoggerService.info('Environment      : ${flavor.env}');

      for (final firebase in flavor.firebase.entries()) {
        if (!PlatformUtils.isEnabled(config, firebase.name)) continue;
        LoggerService.info(
            '${firebase.name.toUpperCase()} App ID    : ${firebase.platform.appId}');
        LoggerService.info(
            '${firebase.name.toUpperCase()} Options   : ${firebase.platform.options}');
      }
      LoggerService.blank();
    }
  }
}
