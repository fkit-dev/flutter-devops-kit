import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Generates project artifacts using FKIT templates.
///
/// Supports generating configured features and components for the current
/// project.
class GenerateCommand extends Command {
  @override
  String get name => 'generate';

  @override
  String get description => 'Run build_runner build';

  @override
  CommandCategory get category => CommandCategory.codeGeneration;

  @override
  String get usage => 'fkit generate';

  @override
  List<String> get examples => const ['fkit generate'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Generating files');

    final config = await ConfigService.load();

    await FlutterService(config).buildRunner();

    LoggerService.blank();

    LoggerService.success('Generation complete.');

    LoggerService.blank();
  }
}
