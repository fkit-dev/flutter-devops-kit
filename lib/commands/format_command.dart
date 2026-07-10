import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';

/// Formats Dart source files in the current FKIT project.
///
/// Runs the configured Dart formatter on project source files.
class FormatCommand extends Command {
  @override
  String get name => 'format';

  @override
  String get description => 'Format Dart files';

  @override
  CommandCategory get category => CommandCategory.development;

  @override
  String get usage => 'fkit format';

  @override
  List<String> get examples => const ['fkit format'];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Formatting project');

    final config = await ConfigService.load();

    await FlutterService(config).format();

    LoggerService.blank();

    LoggerService.success('Formatting complete.');

    LoggerService.blank();
  }
}
