import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Fetches project dependencies for the current FKIT project.
///
/// Runs the configured Flutter dependency resolution command.
class GetCommand extends Command {
  @override
  String get name => 'get';

  @override
  String get description => 'Fetch Flutter dependencies';

  @override
  CommandCategory get category => CommandCategory.development;

  @override
  String get usage => 'fkit get';

  @override
  List<String> get examples => const ['fkit get'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Fetching dependencies');

    final config = await ConfigService.load();

    await FlutterService(config).pubGet();

    LoggerService.blank();

    LoggerService.success('Dependencies installed.');

    LoggerService.blank();
  }
}
