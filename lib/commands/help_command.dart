import '../core/command.dart';
import '../services/logger_service.dart';

class HelpCommand extends Command {
  @override
  String get name => 'help';

  @override
  String get description => 'Show all available commands';

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Flutter DevOps Kit');

    LoggerService.info('Project Commands');

    LoggerService.blank();

    LoggerService.info('init                     Initialize FKIT config');

    LoggerService.info('config                   Print loaded config');

    LoggerService.info('validate                 Validate project setup');

    LoggerService.blank();

    LoggerService.info('Environment Commands');

    LoggerService.blank();

    LoggerService.info('doctor                   Validate environment');

    LoggerService.info('signing setup            Setup Android signing');

    LoggerService.info('signing doctor           Validate Android signing');

    LoggerService.blank();

    LoggerService.info('Dependency Commands');

    LoggerService.blank();

    LoggerService.info('clean                    Clean flutter project');

    LoggerService.info('get                      Fetch dependencies');

    LoggerService.info('fix                      Apply dart fixes');

    LoggerService.info('analyze                  Analyze project');

    LoggerService.info('format                   Format dart files');

    LoggerService.blank();

    LoggerService.info('Code Generation');

    LoggerService.blank();

    LoggerService.info('generate                 Generate build_runner files');

    LoggerService.info('watch                    Watch build_runner changes');

    LoggerService.blank();

    LoggerService.info('Run Commands');

    LoggerService.blank();

    LoggerService.info('run [flavor]             Run app');

    LoggerService.info('run production -p        Run in profile mode');

    LoggerService.info('run production -r        Run in release mode');

    LoggerService.info('run production -t web    Run on web');

    LoggerService.blank();

    LoggerService.info('Build Commands');

    LoggerService.blank();

    LoggerService.info('build apk [flavor]       Build APK');

    LoggerService.info('build aab [flavor]       Build AAB');

    LoggerService.info('build ipa [flavor]       Build IPA');

    LoggerService.info('build web [flavor]       Build Web');

    LoggerService.blank();

    LoggerService.info('Distribution Commands');

    LoggerService.blank();

    LoggerService.info('firebase [flavor]        Upload APK to Firebase');

    LoggerService.blank();

    LoggerService.info('Feature Commands');

    LoggerService.blank();

    LoggerService.info('feat <name>              Create feature module');

    LoggerService.blank();

    LoggerService.info('Examples');

    LoggerService.blank();

    LoggerService.info('fkit build apk production');

    LoggerService.info('fkit build web');

    LoggerService.info('fkit firebase production');

    LoggerService.info('fkit signing setup');

    LoggerService.blank();
  }
}
