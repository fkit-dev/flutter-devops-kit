import 'dart:io';

import 'package:yaml/yaml.dart';

import '../models/project_config.dart';

class ConfigService {
  static Future<ProjectConfig> load() async {
    final file = File('fkit.yaml');

    if (!file.existsSync()) {
      throw Exception('❌ fkit.yaml not found in project root');
    }

    final content = await file.readAsString();

    final yamlMap = loadYaml(content);

    return ProjectConfig.fromMap(yamlMap);
  }
}
