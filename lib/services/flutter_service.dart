import '../models/init_config.dart';
import '../utils/command_executor.dart';

class FlutterService {
  FlutterService(this.config);

  final InitConfig config;

  late final List<String> _flutterCommand = _resolveFlutterCommand();

  late final List<String> _dartCommand = _resolveDartCommand();

  late final List<String> _pubCommand = _resolvePubCommand();

  Future<void> _execute(List<String> command, List<String> args) async {
    await CommandExecutor.run(command.first, [...command.skip(1), ...args]);
  }
  // ---------------------------------------------------------------------------
  // Flutter
  // ---------------------------------------------------------------------------

  Future<void> runFlutter(List<String> args) => _execute(_flutterCommand, args);

  Future<void> clean() async {
    await runFlutter(['clean']);
  }

  Future<void> pubGet() async {
    await runFlutter(['pub', 'get']);
  }

  Future<void> genL10n() async {
    await runFlutter(['gen-l10n']);
  }

  // ---------------------------------------------------------------------------
  // Dart
  // ---------------------------------------------------------------------------

  Future<void> runDart(List<String> args) => _execute(_dartCommand, args);

  Future<void> analyze({String target = 'lib'}) async {
    await runDart(['analyze', target]);
  }

  Future<void> format({String target = 'lib'}) async {
    await runDart(['format', target]);
  }

  Future<void> fix() async {
    await runDart(['fix', '--apply']);
  }

  Future<void> watchBuildRunner() async {
    await runDart(['run', 'build_runner', 'watch', '--delete-conflicting-outputs']);
  }

  // ---------------------------------------------------------------------------
  // Flutter Pub
  // ---------------------------------------------------------------------------

  Future<void> runPub(List<String> args) => _execute(_pubCommand, args);

  Future<void> buildRunner() async {
    await runPub(['run', 'build_runner', 'build', '--delete-conflicting-outputs']);
  }

  // ---------------------------------------------------------------------------
  // Resolve Commands
  // ---------------------------------------------------------------------------

  List<String> _resolveFlutterCommand() {
    if (config.useFvm) return ['fvm', 'flutter'];
    return ['flutter'];
  }

  List<String> _resolveDartCommand() {
    if (config.useFvm) return ['fvm', 'dart'];
    return ['dart'];
  }

  List<String> _resolvePubCommand() {
    if (config.useFvm) return ['fvm', 'flutter', 'pub'];
    return ['flutter', 'pub'];
  }

  Future<void> build(List<String> args) => runFlutter(['build', ...args]);

  Future<void> run(List<String> args) => runFlutter(['run', ...args]);
}
