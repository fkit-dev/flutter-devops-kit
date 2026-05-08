import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../utils/command_executor.dart';

class AnalyzeCommand extends Command {
  @override
  String get name => 'analyze';

  @override
  String get description => 'Analyze Flutter project';

  @override
  Future<void> run(List<String> args) async {
    print('\n🔍 Analyzing project...\n');

    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.dartCommand;

    await CommandExecutor.run(command.first, [...command.skip(1), 'analyze', 'lib']);

    print('\n✅ Analysis complete.\n');
  }
}
