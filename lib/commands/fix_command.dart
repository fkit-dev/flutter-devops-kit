import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Applies automated Dart fixes to the current FKIT project.
///
/// Runs the Dart fix command to resolve supported analysis issues.
class FixCommand extends Command {
  @override
  String get name => 'fix';

  @override
  String get description => 'Apply Dart fixes';

  @override
  CommandCategory get category => CommandCategory.development;

  @override
  String get usage => 'fkit fix';

  @override
  List<String> get examples => const ['fkit fix'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Applying Dart fixes');

    final config = await ConfigService.load();

    await FlutterService(config).fix();

    LoggerService.blank();

    LoggerService.success('Dart fixes applied.');

    LoggerService.blank();
  }
}
