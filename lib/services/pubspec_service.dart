import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'config_service.dart';
import 'flutter_service.dart';
import 'logger_service.dart';

class PubspecService {
  final File _file = File('pubspec.yaml');

  late final YamlEditor _editor;
  bool _modified = false;
  bool _loaded = false;

  Future<void> set(List<Object> path, Object? value) async {
    _editor.update(path, value);
    _modified = true;
  }

  Future<void> ensureLocalization() async {
    await _ensureLoaded();
    await ensureFlutterSdkDependency('flutter_localizations');
    await ensureDependency('intl');
    await ensureFlutterGenerate();
    await save();
  }

  Future<void> ensureDependency(String package,
      {String version = 'any', bool ensureLoaded = false}) async {
    if (ensureLoaded) await _ensureLoaded();
    final dependencies = _dependencies();

    if (dependencies.containsKey(package)) return;

    await set(['dependencies', package], version);
    LoggerService.success('Added dependency: $package');
  }

  Future<void> ensureFlutterSdkDependency(String package) async {
    final dependencies = _dependencies();

    if (dependencies.containsKey(package)) return;
    await set(['dependencies', package], {'sdk': 'flutter'});

    LoggerService.success('Added Flutter dependency: $package');
  }

  Future<void> ensureDevDependency(String package,
      {String version = 'any', bool ensureLoaded = false}) async {
    if (ensureLoaded) await _ensureLoaded();
    final devDependencies = _devDependencies();
    if (devDependencies.containsKey(package)) return;
    await set(['dev_dependencies', package], version);
    LoggerService.success('Added dev dependency: $package');
  }

  Future<void> ensureDependencies(Map<String, String> packages) async {
    await _ensureLoaded();
    for (final entry in packages.entries) {
      await ensureDependency(entry.key, version: entry.value);
    }
  }

  Future<void> ensureDevDependencies(Map<String, String> packages) async {
    await _ensureLoaded();
    for (final entry in packages.entries) {
      await ensureDevDependency(entry.key, version: entry.value);
    }
  }

  Future<void> ensureFlutterGenerate() async {
    final flutter = _flutter();
    if (flutter['generate'] == true) return;
    await set(['flutter', 'generate'], true);
    LoggerService.success('Enabled flutter.generate');
  }

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
