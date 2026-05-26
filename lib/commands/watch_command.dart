import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../utils/command_executor.dart';

class WatchCommand extends Command {
  @override
  String get name => 'watch';

  @override
  String get description => 'Run build_runner watch';

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Watching for file changes');
    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.dartCommand;

    await CommandExecutor.run(command.first, [...command.skip(1), 'run', 'build_runner', 'watch', '--delete-conflicting-outputs']);
  }
}
