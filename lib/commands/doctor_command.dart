import '../core/command.dart';
import '../services/logger_service.dart';
import '../utils/process_utils.dart';

class DoctorCommand extends Command {
  @override
  String get name => 'doctor';

  @override
  String get description => 'Validate development environment';

  int _success = 0;
  int _failed = 0;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Running Flutter DevOps diagnostics');

    await _check('Flutter', 'flutter');
    await _check('Dart', 'dart');
    await _check('Firebase CLI', 'firebase');
    await _check('CocoaPods', 'pod');
    await _check('Java', 'java');
    await _check('Git', 'git');

    LoggerService.divider();

    LoggerService.success('Installed : $_success');

    if (_failed > 0) {
      LoggerService.error('Missing : $_failed');
    } else {
      LoggerService.success('Missing : 0');
    }

    LoggerService.blank();

    if (_failed == 0) {
      LoggerService.success('Environment ready.');
    } else {
      LoggerService.warning('Some required tools are missing.');
    }

    LoggerService.blank();
  }

  Future<void> _check(String title, String command) async {
    final exists = await ProcessUtils.commandExists(command);

    if (exists) {
      _success++;

      LoggerService.success('$title installed');
    } else {
      _failed++;

      LoggerService.error('$title missing');
    }
  }
}
