import 'dart:io';

import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import 'template_renderer.dart';

/// Provides reusable file and template generation utilities.
///
/// Generator implementations can use this mixin to manage directories, write
/// generated files, render templates, resolve variables, and handle overwrite
/// confirmation.
mixin GeneratorMixin {
// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

  /// Determines whether the specified [entity] should be generated.
  ///
  /// Returns `true` when the entity does not exist or when [overwrite] is
  /// enabled. Otherwise, prompts the user to confirm overwriting the entity.
  Future<bool> shouldGenerate(
    FileSystemEntity entity, {
    bool overwrite = false,
  }) async {
    if (!entity.existsSync()) return true;
    if (overwrite) return true;

    return PromptService.confirm(
      '${entity.path} already exists. Overwrite?',
      defaultValue: false,
    );
  }

  /// Ensures that the specified [directory] exists.
  ///
  /// Creates the directory and any missing parent directories when necessary.
  Future<void> ensureDirectory(Directory directory) async {
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
      LoggerService.success('Created ${directory.path}');
    }
  }

  /// Writes [content] to the specified [file].
  ///
  /// Existing files are skipped unless [overwrite] is `true`. Missing parent
  /// directories are created automatically.
  Future<void> writeFile({
    required File file,
    required String content,
    bool overwrite = false,
  }) async {
    if (file.existsSync() && !overwrite) {
      LoggerService.info('Skipped ${file.path}');
      return;
    }

    await file.parent.create(recursive: true);

    await file.writeAsString(content);

    LoggerService.success('Generated ${file.path}');
  }

  /// Creates a path by combining [featurePath] with a [relative] path.
  String path(String featurePath, String relative) {
    return '$featurePath/$relative';
  }

  /// Renders a template and writes the generated content to [output].
  ///
  /// The template is loaded from [templateRoot], rendered using [variables],
  /// and written to the output path. Existing files are replaced only when
  /// [overwrite] is `true`.
  Future<void> generateTemplate({
    required String templateRoot,
    required String template,
    required String output,
    required Map<String, dynamic> variables,
    bool overwrite = false,
  }) async {
    final content = await TemplateRenderer.render(
      templateRoot: templateRoot,
      template: template,
      variables: variables,
    );

    await writeFile(
      file: File(output),
      content: content,
      overwrite: overwrite,
    );
  }

  /// Replaces template placeholders in [value] using the provided [variables].
  String resolveVariables(
    String value,
    Map<String, dynamic> variables,
  ) {
    return TemplateRenderer.renderString(value, variables);
  }

  /// Prompts the user to confirm overwriting an existing item.
  ///
  /// The provided [description] is included in the confirmation message.
  Future<bool> confirmOverwrite(String description) async {
    return PromptService.confirm(
      '$description already exists. Overwrite?',
      defaultValue: false,
    );
  }
}
