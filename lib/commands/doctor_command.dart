import '../core/command.dart';
import '../core/command_category.dart';
import '../services/logger_service.dart';
import '../utils/process_utils.dart';

class DoctorCommand extends Command {
  @override
  String get name => 'doctor';

  @override
  String get description => 'Validate development environment';

  @override
  CommandCategory get category => CommandCategory.environment;

  @override
  String get usage => 'fkit doctor';

  @override
  List<String> get examples => const ['fkit doctor'];

  int _success = 0;

  int _failed = 0;

  @override
  Future<void> run(List<String> args) async {
    _success = 0;
    _failed = 0;

    LoggerService.section('Running Flutter DevOps Diagnostics');

    await _check(
      'Flutter',
      'flutter',
    );

    await _check(
      'Dart',
      'dart',
    );

    await _check(
      'Firebase CLI',
      'firebase',
    );

    await _check(
      'CocoaPods',
      'pod',
    );

    await _check(
      'Java',
      'java',
    );

    await _check(
      'Git',
      'git',
    );

    LoggerService.divider();

    LoggerService.success(
      'Installed : $_success',
    );

    if (_failed == 0) {
      LoggerService.success(
        'Missing   : 0',
      );

      LoggerService.blank();

      LoggerService.success(
        'Environment is ready.',
      );
    } else {
      LoggerService.error(
        'Missing   : $_failed',
      );

      LoggerService.blank();

      LoggerService.warning(
        'Some required tools are missing.',
      );
    }

    LoggerService.blank();
  }

  Future<void> _check(
    String title,
    String command,
  ) async {
    final exists = await ProcessUtils.commandExists(
      command,
    );

    if (exists) {
      _success++;

      LoggerService.success(
        '$title installed',
      );

      return;
    }

    _failed++;

    LoggerService.error(
      '$title missing',
    );
  }
}
