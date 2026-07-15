import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Runs code generation in watch mode.
///
/// Continuously monitors project files and regenerates code when changes are
/// detected.
class WatchCommand extends Command {
  @override
  String get name => 'watch';

  @override
  String get description => 'Run build_runner in watch mode';

  @override
  CommandCategory get category => CommandCategory.codeGeneration;

  @override
  String get usage => 'fkit watch';

  @override
  List<String> get examples => const ['fkit watch'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Watching for file changes');

    final config = await ConfigService.load();

    await FlutterService(config).watchBuildRunner();
  }
}
