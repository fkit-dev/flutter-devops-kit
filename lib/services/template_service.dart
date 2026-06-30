import 'dart:io';

import 'package:yaml/yaml.dart';

import '../generators/core/package_locator.dart';
import '../models/template/template_definition.dart';

class TemplateService {
  const TemplateService._();

  static Future<TemplateDefinition> load(String template) async {
    final root = const PackageLocator().packageRoot();

    final file = File('${root.path}/templates/$template/template.yaml');

    if (!file.existsSync()) throw Exception('Template "$template" not found.');

    final yaml = loadYaml(await file.readAsString());

    return TemplateDefinition.fromMap(Map<dynamic, dynamic>.from(yaml));
  }
}
