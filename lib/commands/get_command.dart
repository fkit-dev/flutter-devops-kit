import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../utils/command_executor.dart';

class GetCommand extends Command {
  @override
  String get name => 'get';

  @override
  String get description => 'Run flutter pub get';

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Fetching dependencies');
    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.flutterCommand;

    await CommandExecutor.run(command.first, [...command.skip(1), 'pub', 'get']);

    LoggerService.blank();

    LoggerService.success('Dependencies installed.');

    LoggerService.blank();
  }
}
