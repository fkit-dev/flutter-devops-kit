import 'dart:io';

import 'package:yaml/yaml.dart';

import '../generators/core/package_locator.dart';
import '../models/template/template_definition.dart';

/// Loads and parses FKIT template definitions.
class TemplateService {
  const TemplateService._();

  ///ADD NEW MODULE HERE NO OTHER CHANGES REQUIRED
  static const _sections = <String>[
    'feature',
    'components',
    'groups',
    'barrel',
    'di',
    'router',
    'modules'
  ];

  /// Loads the definition for the specified [template].
  ///
  /// Returns the parsed [TemplateDefinition] for the template.
  static Future<TemplateDefinition> load(String template) async {
    final root = const PackageLocator().packageRoot();
    final templateRoot = '${root.path}/templates/$template';

    final manifest = File('$templateRoot/template.yaml');

    if (!manifest.existsSync()) {
      throw Exception('Template "$template" not found.');
    }

    final map = await _readYaml(manifest);

    final files = Map<dynamic, dynamic>.from(map['files'] ?? const {});

    for (final section in _sections) {
      map[section] = await _loadSection(
          templateRoot: templateRoot, files: files, section: section);
    }

    return TemplateDefinition.fromMap(map);
  }

  static Future<Map<dynamic, dynamic>> _loadSection(
      {required String templateRoot,
      required Map<dynamic, dynamic> files,
      required String section}) async {
    final relative = files[section];

    if (relative == null) return {};

    final file = File('$templateRoot/$relative');

    if (!file.existsSync()) {
      throw Exception(
          'Missing template file "$relative" for section "$section".');
    }

    return _readYaml(file);
  }

  static Future<Map<dynamic, dynamic>> _readYaml(File file) async {
    return Map<dynamic, dynamic>.from(
      loadYaml(await file.readAsString()),
    );
  }
}
