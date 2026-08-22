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

  static const _requiredManifestKeys = <String>[
    'schema',
    'name',
    'display_name',
    'description',
    'version',
    'author',
    'supports',
    'files',
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
    if (map.isEmpty) {
      throw Exception(
        'Template "$template" is unavailable: template.yaml is empty. '
        'Available templates: ${await availableTemplates()}.',
      );
    }

    final missing =
        _requiredManifestKeys.where((key) => !map.containsKey(key)).toList();
    if (missing.isNotEmpty) {
      throw Exception(
        'Template "$template" is invalid: missing manifest fields '
        '${missing.join(', ')}.',
      );
    }

    final files = Map<dynamic, dynamic>.from(map['files'] ?? const {});
    final missingSections = <String>[];

    for (final section in _sections) {
      if (!files.containsKey(section)) missingSections.add(section);
      map[section] = await _loadSection(
          templateRoot: templateRoot, files: files, section: section);
    }

    if (missingSections.isNotEmpty) {
      throw Exception(
        'Template "$template" is invalid: missing section mappings '
        '${missingSections.join(', ')}.',
      );
    }

    await _validateReferences(
      template: template,
      templateRoot: templateRoot,
      manifest: map,
    );

    try {
      return TemplateDefinition.fromMap(map);
    } on TypeError catch (error) {
      throw Exception(
        'Template "$template" is invalid: $error',
      );
    }
  }

  /// Returns template directories that contain a non-empty manifest.
  static Future<List<String>> availableTemplates() async {
    final root = const PackageLocator().packageRoot();
    final directory = Directory('${root.path}/templates');
    if (!directory.existsSync()) return const [];

    final names = <String>[];
    await for (final entity in directory.list()) {
      if (entity is! Directory) continue;
      final manifest = File('${entity.path}/template.yaml');
      if (!manifest.existsSync()) continue;
      final content = await manifest.readAsString();
      if (content.trim().isNotEmpty) {
        names.add(entity.path.split('/').last);
      }
    }
    names.sort();
    return names;
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

  static Future<void> _validateReferences({
    required String template,
    required String templateRoot,
    required Map<dynamic, dynamic> manifest,
  }) async {
    final missing = <String>[];

    void requireTemplate(String? relative, String description) {
      if (relative == null || relative.isEmpty) return;
      final file = File('$templateRoot/$relative');
      if (!file.existsSync()) {
        missing.add('$description: $relative');
      }
    }

    final setup = Map<dynamic, dynamic>.from(manifest['setup'] ?? const {});
    final bootstrap =
        Map<dynamic, dynamic>.from(setup['bootstrap'] ?? const {});
    requireTemplate(
      _bootstrapTemplate(bootstrap['app']),
      'bootstrap app',
    );
    requireTemplate(
      _bootstrapTemplate(bootstrap['main']),
      'bootstrap main',
    );

    final feature = Map<dynamic, dynamic>.from(manifest['feature'] ?? const {});
    for (final file in feature['files'] as List<dynamic>? ?? const []) {
      final map = Map<dynamic, dynamic>.from(file);
      requireTemplate(map['template']?.toString(), 'feature file');
    }

    final components =
        Map<dynamic, dynamic>.from(manifest['components'] ?? const {});
    for (final entry in components.entries) {
      final map = Map<dynamic, dynamic>.from(entry.value);
      requireTemplate(
        map['template']?.toString(),
        'component "${entry.key}"',
      );
    }

    final moduleNames = <String>{
      ...List<String>.from(setup['modules'] ?? const []),
      ...Map<dynamic, dynamic>.from(manifest['modules'] ?? const {}).keys.map(
            (key) => key.toString(),
          ),
    };

    for (final moduleName in moduleNames) {
      final moduleFile = File('$templateRoot/modules/$moduleName/module.yaml');
      if (!moduleFile.existsSync()) {
        missing.add('module "$moduleName": module.yaml');
        continue;
      }

      final module = await _readYaml(moduleFile);
      for (final file in module['files'] as List<dynamic>? ?? const []) {
        final map = Map<dynamic, dynamic>.from(file);
        final relative = map['template']?.toString();
        if (relative == null || relative.isEmpty) continue;
        final templateFile =
            File('$templateRoot/modules/$moduleName/$relative');
        if (!templateFile.existsSync()) {
          missing.add('module "$moduleName" template: $relative');
        }
      }
    }

    if (missing.isNotEmpty) {
      throw Exception(
        'Template "$template" references missing files:\n'
        '${missing.map((item) => '  - $item').join('\n')}',
      );
    }
  }

  static String? _bootstrapTemplate(dynamic value) {
    if (value is! Map) return null;
    return Map<dynamic, dynamic>.from(value)['template']?.toString();
  }

  static Future<Map<dynamic, dynamic>> _readYaml(File file) async {
    final content = await file.readAsString();
    if (content.trim().isEmpty) return {};
    return Map<dynamic, dynamic>.from(
      loadYaml(content),
    );
  }
}
