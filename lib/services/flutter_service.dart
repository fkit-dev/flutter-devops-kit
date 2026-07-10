import '../models/init_config.dart';
import '../utils/command_executor.dart';

/// Provides utilities for executing Flutter and Dart commands.
///
/// Resolves commands based on the project configuration, including FVM
/// support, and exposes common development, generation, and build operations.
class FlutterService {
  /// Creates a Flutter service using the provided project [config].
  FlutterService(this.config);

  /// The project configuration used to resolve Flutter and Dart commands.
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

  /// Executes a Flutter command with the provided [args].
  Future<void> runFlutter(List<String> args) => _execute(_flutterCommand, args);

  /// Runs `flutter clean`.
  Future<void> clean() async {
    await runFlutter(['clean']);
  }

  /// Fetches project dependencies using `flutter pub get`.
  Future<void> pubGet() async {
    await runFlutter(['pub', 'get']);
  }

  /// Generates Flutter localization files.
  Future<void> genL10n() async {
    await runFlutter(['gen-l10n']);
  }

// ---------------------------------------------------------------------------
// Dart
// ---------------------------------------------------------------------------

  /// Executes a Dart command with the provided [args].
  Future<void> runDart(List<String> args) => _execute(_dartCommand, args);

  /// Analyzes the specified [target].
  ///
  /// Defaults to the `lib` directory.
  Future<void> analyze({String target = 'lib'}) async {
    await runDart(['analyze', target]);
  }

  /// Formats Dart files in the specified [target].
  ///
  /// Defaults to the `lib` directory.
  Future<void> format({String target = 'lib'}) async {
    await runDart(['format', target]);
  }

  /// Applies automated Dart fixes to the project.
  Future<void> fix() async {
    await runDart(['fix', '--apply']);
  }

  /// Runs build runner in watch mode.
  ///
  /// Conflicting generated outputs are deleted automatically.
  Future<void> watchBuildRunner() async {
    await runDart([
      'run',
      'build_runner',
      'watch',
      '--delete-conflicting-outputs',
    ]);
  }

// ---------------------------------------------------------------------------
// Flutter Pub
// ---------------------------------------------------------------------------

  /// Executes a Flutter pub command with the provided [args].
  Future<void> runPub(List<String> args) => _execute(_pubCommand, args);

  /// Runs build runner to generate project files.
  ///
  /// Conflicting generated outputs are deleted automatically.
  Future<void> buildRunner() async {
    await runPub([
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ]);
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

  /// Runs a Flutter build command with the provided [args].
  Future<void> build(List<String> args) => runFlutter(['build', ...args]);

  /// Runs the Flutter application with the provided [args].
  Future<void> run(List<String> args) => runFlutter(['run', ...args]);

  /// Executes configured post-generation tasks.
  ///
  /// Optionally generates localization files, runs build runner, and formats
  /// generated source files.
  Future<void> postGenerate({
    bool buildRunner = false,
    bool format = true,
    bool genL10n = false,
  }) async {
    if (genL10n) await this.genL10n();
    if (buildRunner) await this.buildRunner();
    if (format) await this.format();
  }

  /// Generates launcher icons using `flutter_launcher_icons`.
  Future<void> launcherIcons() async {
    await runPub(['run', 'flutter_launcher_icons']);
  }
}
