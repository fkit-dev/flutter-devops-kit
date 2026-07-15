import 'dart:io';

import 'package:yaml_edit/yaml_edit.dart';

/// Updates individual sections in `fkit.yaml`.
class ConfigSectionWriter {
  /// Creates a configuration section writer.
  const ConfigSectionWriter();

  /// Updates one or more top-level YAML [sections].
  Future<void> write(
    Map<String, Object?> sections,
  ) async {
    final file = File('fkit.yaml');

    if (!file.existsSync()) {
      throw Exception(
        'fkit.yaml not found. Run "fkit init" first.',
      );
    }

    final content = await file.readAsString();
    final editor = YamlEditor(content);

    for (final entry in sections.entries) {
      editor.update(
        [entry.key],
        entry.value,
      );
    }

    await file.writeAsString(
      editor.toString(),
    );
  }
}
