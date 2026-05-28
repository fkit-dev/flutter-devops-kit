import '../core/command.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';

class ConfigCommand extends Command {
  @override
  String get name => 'config';

  @override
  String get description => 'Print loaded config';

  @override
  Future<void> run(List<String> args) async {
    final config = await ConfigService.load();

    LoggerService.section('Loaded Project Config');

    LoggerService.info('Use FVM        : ${config.useFvm}');

    LoggerService.info('Main Entry     : ${config.mainEntry}');

    LoggerService.info('Flavoring Enabled : ${config.flavoringEnabled}');

    LoggerService.info('Default Flavor : ${config.defaultFlavor}');

    LoggerService.info('Tester Group   : ${config.testerGroup}');

    LoggerService.blank();

    LoggerService.section('Platforms');

    LoggerService.info('Android : ${config.platforms.android}');

    LoggerService.info('iOS      : ${config.platforms.ios}');

    LoggerService.info('Web      : ${config.platforms.web}');

    LoggerService.blank();

    LoggerService.section('Flavors');

    config.flavors.forEach((key, value) {
      LoggerService.command(key);

      LoggerService.info('Env File : ${value.env}');

      LoggerService.info(
        'Firebase Distribution ID : '
        '${value.firebase.appDistributionId}',
      );

      LoggerService.info('Firebase Options:');

      value.firebase.options.forEach((platform, path) {
        LoggerService.info('$platform -> $path');
      });

      LoggerService.blank();
    });
  }
}
