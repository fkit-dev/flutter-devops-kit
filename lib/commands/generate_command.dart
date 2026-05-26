import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../utils/command_executor.dart';

class GenerateCommand extends Command {
  @override
  String get name => 'generate';

  @override
  String get description => 'Run build_runner build';

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Generating files');
    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.flutterPubCommand;

    await CommandExecutor.run(command.first, [...command.skip(1), 'run', 'build_runner', 'build', '--delete-conflicting-outputs']);

    LoggerService.blank();

    LoggerService.success('Generation complete.');

    LoggerService.blank();
  }
}
