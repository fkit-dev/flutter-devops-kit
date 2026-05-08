import '../core/command.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../utils/command_executor.dart';

class FormatCommand extends Command {
  @override
  String get name => 'format';

  @override
  String get description => 'Format dart files';

  @override
  Future<void> run(List<String> args) async {
    print('\n✨ Formatting project...\n');

    final config = await ConfigService.load();

    final flutterService = FlutterService(config);

    final command = flutterService.dartCommand;

    await CommandExecutor.run(command.first, [...command.skip(1), 'format', 'lib']);

    print('\n✅ Formatting complete.\n');
  }
}
