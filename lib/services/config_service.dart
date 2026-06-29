import 'dart:io';

import 'package:yaml/yaml.dart';

import '../models/init_config.dart';

class ConfigService {
  static Future<InitConfig> load() async {
    final file = File('fkit.yaml');

    if (!file.existsSync()) {
      throw Exception('❌ fkit.yaml not found in init root');
    }

    final content = await file.readAsString();
    final yamlMap = loadYaml(content);
    return InitConfig.fromMap(yamlMap);
  }
}
