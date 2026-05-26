import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../utils/command_executor.dart';

class FixCommand extends Command {
  @override
  String get name => 'fix';

  @override
  String get description => 'Apply dart fixes';

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Applying Dart fixes');
    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.dartCommand;

    await CommandExecutor.run(command.first, [...command.skip(1), 'fix', '--apply']);

    LoggerService.blank();

    LoggerService.success('Dart fixes applied.');

    LoggerService.blank();
  }
}
