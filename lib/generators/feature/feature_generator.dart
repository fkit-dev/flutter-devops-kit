import 'dart:io';

import '../core/generator_context.dart';
import '../core/generator_mixin.dart';
import '../maintainers/barrel_maintainer.dart';
import '../maintainers/di_maintainer.dart';

class FeatureGenerator with GeneratorMixin {
  Future<void> generate(GeneratorContext context,
      {bool overwrite = false}) async {
    final featureDir = Directory(context.featurePath);

    if (featureDir.existsSync() && !overwrite) {
      final shouldContinue = await shouldGenerate(featureDir);
      if (!shouldContinue) return;
    }

    await _createDirectories(context);
    await _generateFiles(context, overwrite: overwrite);
    await BarrelMaintainer().maintain(context);
    await DiMaintainer().maintain(context);
  }

  Future<void> _createDirectories(GeneratorContext context) async {
    for (final folder in context.template.feature.folders) {
      await ensureDirectory(Directory(path(context.featurePath, folder)));
    }
  }

  Future<void> _generateFiles(GeneratorContext context,
      {required bool overwrite}) async {
    final variables = context.naming.variables;

    for (final file in context.template.feature.files) {
      final output = resolveVariables(file.output, variables);

      await generateTemplate(
        templateRoot: context.template.name,
        template: file.template,
        output: path(context.featurePath, output),
        variables: variables,
        overwrite: overwrite,
      );
    }
  }
}
