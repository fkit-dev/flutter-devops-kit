import '../core/command.dart';
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
    print('\n🩺 Running Flutter DevOps diagnostics...\n');

    await _check('Flutter', 'flutter');
    await _check('Dart', 'dart');
    await _check('Firebase CLI', 'firebase');
    await _check('CocoaPods', 'pod');
    await _check('Java', 'java');
    await _check('Git', 'git');

    print('\n────────────────────────');

    print('✔ Installed : $_success');
    print('✘ Missing   : $_failed');

    if (_failed == 0) {
      print('\n✅ Environment ready.\n');
    } else {
      print('\n⚠ Some required tools are missing.\n');
    }
  }

  Future<void> _check(String title, String command) async {
    final exists = await ProcessUtils.commandExists(command);

    if (exists) {
      _success++;
      print('✔ $title installed');
    } else {
      _failed++;
      print('✘ $title missing');
    }
  }
}
