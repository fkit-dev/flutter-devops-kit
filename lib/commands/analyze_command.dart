import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Analyzes Dart source files in the current FKIT project.
///
/// Runs the configured Dart analyzer to report code issues.
class AnalyzeCommand extends Command {
  @override
  String get name => 'analyze';

  @override
  String get description => 'Analyze Flutter project';

  @override
  CommandCategory get category => CommandCategory.dependency;

  @override
  String get usage => 'fkit analyze';

  @override
  List<String> get examples => const [
        'fkit analyze',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Analyzing project');

    final config = await ConfigService.load();

    await FlutterService(config).analyze();

    LoggerService.blank();

    LoggerService.success('Analysis complete.');

    LoggerService.blank();
  }
}
