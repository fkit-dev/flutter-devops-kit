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

    LoggerService.info('Available Commands:');

    LoggerService.blank();

    LoggerService.info('help                    Show available commands');

    LoggerService.info('doctor                  Validate environment');

    LoggerService.info('config                  Print loaded config');

    LoggerService.info('clean                   Clean flutter project');

    LoggerService.info('get                     Fetch dependencies');

    LoggerService.info('fix                     Apply dart fixes');

    LoggerService.info('analyze                 Analyze project');

    LoggerService.info('format                  Format dart files');

    LoggerService.info('generate                Generate build_runner files');

    LoggerService.info('watch                   Watch build_runner changes');

    LoggerService.info('run <flavor>            Run app');

    LoggerService.info('build apk <flavor>      Build APK');

    LoggerService.info('build aab <flavor>      Build AAB');

    LoggerService.info('build ipa <flavor>      Build IPA');

    LoggerService.info('build web <flavor>      Build Web');

    LoggerService.info('firebase <flavor>       Upload APK to Firebase');

    LoggerService.blank();
  }
}
