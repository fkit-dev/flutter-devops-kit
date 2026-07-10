import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Cleans generated build files for the current FKIT project.
///
/// Runs the configured Flutter clean command.
class CleanCommand extends Command {
  @override
  String get name => 'clean';

  @override
  String get description => 'Clean Flutter project';

  @override
  CommandCategory get category => CommandCategory.development;

  @override
  String get usage => 'fkit clean';

  @override
  List<String> get examples => const ['fkit clean'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Cleaning Flutter project');

    final config = await ConfigService.load();

    await FlutterService(config).clean();

    LoggerService.blank();

    LoggerService.success('Project cleaned.');

    LoggerService.blank();
  }
}
