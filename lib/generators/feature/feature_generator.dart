import 'dart:io';

import '../core/generator_context.dart';
import '../core/generator_mixin.dart';

class FeatureGenerator with GeneratorMixin {
  Future<void> generate(GeneratorContext context, {bool overwrite = false}) async {
    final featureDir = Directory(context.featurePath);

    if (featureDir.existsSync() && !overwrite) {
      final shouldContinue = await shouldGenerate(featureDir);

      if (!shouldContinue) return;
    }

    await _createDirectories(context);

    await _generateFiles(context, overwrite: overwrite);
  }

  Future<void> _createDirectories(GeneratorContext context) async {
    for (final folder in context.template.feature.folders) {
      await ensureDirectory(Directory(path(context, folder)));
    }
  }

  Future<void> _generateFiles(GeneratorContext context, {required bool overwrite}) async {
    final variables = context.naming.variables;

    for (final file in context.template.feature.files) {
      final output = resolveVariables(file.output, variables);

      await generateTemplate(
          context: context, template: file.template, output: path(context, output), variables: variables, overwrite: overwrite);
    }
  }
}
