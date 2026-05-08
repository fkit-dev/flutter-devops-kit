import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../utils/command_executor.dart';

class CleanCommand extends Command {
  @override
  String get name => 'clean';

  @override
  String get description => 'Run flutter clean';

  @override
  Future<void> run(List<String> args) async {
    print('\n🧹 Cleaning Flutter project...\n');

    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.flutterCommand;
    await CommandExecutor.run(command.first, [...command.skip(1), 'clean']);

    print('\n✅ Project cleaned.\n');
  }
}
