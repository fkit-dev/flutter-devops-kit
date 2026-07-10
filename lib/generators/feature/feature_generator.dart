import 'dart:io';

import '../core/generator_context.dart';
import '../core/generator_mixin.dart';

/// Generates feature files from FKIT template definitions.
class FeatureGenerator with GeneratorMixin {
  /// Generates a feature using the provided generation configuration.
  ///
  /// Returns whether the feature generation process completed successfully.
  Future<bool> generate(
    GeneratorContext context, {
    bool overwrite = false,
  }) async {
    final featureDir = Directory(context.featurePath);

    if (featureDir.existsSync() && !overwrite) {
      final shouldContinue = await shouldGenerate(featureDir);

      if (!shouldContinue) {
        return false;
      }
    }

    await _createDirectories(context);

    await _generateFiles(
      context,
      overwrite: overwrite,
    );

    return true;
  }

  Future<void> _createDirectories(
    GeneratorContext context,
  ) async {
    for (final folder in context.template.feature.folders) {
      await ensureDirectory(
        Directory(
          path(context.featurePath, folder),
        ),
      );
    }
  }

  Future<void> _generateFiles(
    GeneratorContext context, {
    required bool overwrite,
  }) async {
    final variables = context.naming.variables;

    for (final file in context.template.feature.files) {
      final output = resolveVariables(
        file.output,
        variables,
      );

      await generateTemplate(
        templateRoot: context.template.name,
        template: file.template,
        output: path(
          context.featurePath,
          output,
        ),
        variables: variables,
        overwrite: overwrite,
      );
    }
  }
}
