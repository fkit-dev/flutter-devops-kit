import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'config_service.dart';
import 'flutter_service.dart';
import 'logger_service.dart';

/// Provides utilities for updating the project's `pubspec.yaml` file.
///
/// Supports adding dependencies, configuring Flutter localization generation,
/// saving changes, and running dependency resolution after modifications.
class PubspecService {
  /// Creates a service for managing the project's pubspec configuration.
  PubspecService();
  final File _file = File('pubspec.yaml');

  late final YamlEditor _editor;
  bool _modified = false;
  bool _loaded = false;

  Future<void> _set(List<Object> path, Object? value) async {
    _editor.update(path, value);
    _modified = true;
  }

  /// Ensures that the project is configured for Flutter localization.
  ///
  /// Adds the required localization dependencies, enables Flutter code
  /// generation, and saves the updated `pubspec.yaml` file.
  Future<void> ensureLocalization() async {
    await _ensureLoaded();
    await ensureFlutterSdkDependency('flutter_localizations');
    await ensureDependency('intl');
    await ensureFlutterGenerate();
    await save();
  }

  /// Ensures that [package] exists in the project's dependencies.
  ///
  /// Adds the dependency using the specified [version] if it is not already
  /// present. When [ensureLoaded] is `true`, the pubspec is loaded before
  /// checking the dependencies.
  Future<void> ensureDependency(
    String package, {
    String version = 'any',
    bool ensureLoaded = false,
  }) async {
    if (ensureLoaded) await _ensureLoaded();
    final dependencies = _dependencies();

    if (dependencies.containsKey(package)) return;

    await _set(['dependencies', package], version);
    LoggerService.success('Added dependency: $package');
  }

  /// Ensures that [package] exists as a Flutter SDK dependency.
  ///
  /// Adds the dependency with the Flutter SDK source if it is not already
  /// present.
  Future<void> ensureFlutterSdkDependency(String package) async {
    final dependencies = _dependencies();

    if (dependencies.containsKey(package)) return;

    await _set(['dependencies', package], {'sdk': 'flutter'});

    LoggerService.success('Added Flutter dependency: $package');
  }

  /// Ensures that [package] exists in the project's development dependencies.
  ///
  /// Adds the dependency using the specified [version] if it is not already
  /// present. When [ensureLoaded] is `true`, the pubspec is loaded before
  /// checking the dependencies.
  Future<void> ensureDevDependency(
    String package, {
    String version = 'any',
    bool ensureLoaded = false,
  }) async {
    if (ensureLoaded) await _ensureLoaded();
    final devDependencies = _devDependencies();

    if (devDependencies.containsKey(package)) return;

    await _set(['dev_dependencies', package], version);
    LoggerService.success('Added dev dependency: $package');
  }

  /// Ensures that all provided [packages] exist in the project dependencies.
  ///
  /// Each map key represents a package name and its value represents the
  /// dependency version.
  Future<void> ensureDependencies(Map<String, String> packages) async {
    await _ensureLoaded();

    for (final entry in packages.entries) {
      await ensureDependency(entry.key, version: entry.value);
    }
  }

  /// Ensures that all provided [packages] exist in the development
  /// dependencies.
  ///
  /// Each map key represents a package name and its value represents the
  /// dependency version.
  Future<void> ensureDevDependencies(Map<String, String> packages) async {
    await _ensureLoaded();

    for (final entry in packages.entries) {
      await ensureDevDependency(entry.key, version: entry.value);
    }
  }

  /// Ensures that Flutter code generation is enabled in `pubspec.yaml`.
  ///
  /// Sets `flutter.generate` to `true` when it is not already enabled.
  Future<void> ensureFlutterGenerate() async {
    final flutter = _flutter();

    if (flutter['generate'] == true) return;

    await _set(['flutter', 'generate'], true);
    LoggerService.success('Enabled flutter.generate');
  }

  /// Saves pending changes to `pubspec.yaml`.
  ///
  /// If changes were made, writes the updated configuration, runs dependency
  /// resolution, and resets the modification state.
  Future<void> save() async {
    if (!_modified) return;

    await _file.writeAsString(_editor.toString());
    final config = await ConfigService.load();
    await FlutterService(config).pubGet();
    _modified = false;
    LoggerService.success('pubspec.yaml updated.');
  }

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    await _load();
    _loaded = true;
  }

  Future<void> _load() async {
    _ensureProject();
    _editor = YamlEditor(await _file.readAsString());
  }

  void _ensureProject() {
    if (!_file.existsSync()) throw Exception('pubspec.yaml not found.');
  }

  Map<dynamic, dynamic> _root() {
    return loadYaml(_editor.toString()) as YamlMap;
  }

  Map<dynamic, dynamic> _dependencies() {
    return _root()['dependencies'] ?? {};
  }

  Map<dynamic, dynamic> _devDependencies() {
    return _root()['dev_dependencies'] ?? {};
  }

  Map<dynamic, dynamic> _flutter() {
    return _root()['flutter'] ?? {};
  }
}
