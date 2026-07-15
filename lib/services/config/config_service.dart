import 'dart:io';

import 'package:yaml/yaml.dart';

import '../../models/init_config.dart';

/// Provides utilities for loading FKIT project configuration.
class ConfigService {
  /// Loads and parses the configuration for the current FKIT project.
  ///
  /// Returns the resulting [InitConfig].
  static Future<InitConfig> load() async {
    final file = File('fkit.yaml');

    if (!file.existsSync()) {
      throw Exception('❌ fkit.yaml not found in project root');
    }

    final content = await file.readAsString();
    final yamlMap = loadYaml(content);
    return InitConfig.fromMap(yamlMap);
  }
}
