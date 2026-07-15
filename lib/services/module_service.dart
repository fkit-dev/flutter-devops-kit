import 'dart:io';

import 'package:yaml/yaml.dart';

import '../generators/core/package_locator.dart';
import '../models/module/module_definition.dart';

/// Loads module definitions from FKIT templates.
class ModuleService {
  /// Creates a module service.
  const ModuleService();

  /// Loads the specified [module] definition from a [template].
  ///
  /// Resolves the FKIT package root and returns the corresponding
  /// [ModuleDefinition].
  Future<ModuleDefinition> load({
    required String template,
    required String module,
  }) async {
    final root = const PackageLocator().packageRoot();

    final file =
        File('${root.path}/templates/$template/modules/$module/module.yaml');

    if (!file.existsSync()) {
      throw Exception('Module "$module" not found in template "$template".');
    }

    final yaml = loadYaml(await file.readAsString());

    return ModuleDefinition.fromMap(Map<dynamic, dynamic>.from(yaml));
  }
}
