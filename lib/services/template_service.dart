import 'dart:io';

import 'package:yaml/yaml.dart';

import '../models/template_config.dart';

class TemplateService {
  static Future<TemplateConfig> loadTemplate(String template) async {
    final file = File('.fkit/templates/$template/folders.yaml');

    if (!file.existsSync()) {
      throw Exception('❌ Template not found: $template');
    }

    final content = await file.readAsString();

    final yaml = loadYaml(content);

    return TemplateConfig.fromMap(yaml);
  }
}
