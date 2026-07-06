import 'dart:io';

import '../core/generator_context.dart';
import '../core/generator_mixin.dart';

class ComponentGenerator with GeneratorMixin {
  const ComponentGenerator();

  Future<void> generate({
    required GeneratorContext context,
    required String component,
    bool overwrite = false,
  }) async {
    final definition = context.template.components[component];

    if (definition == null) throw Exception('Component "$component" is not supported by template "${context.template.name}".');

    final output = resolveVariables(definition.output, context.naming.variables);

    final file = File(path(context.featurePath, output));

    final shouldContinue = await shouldGenerate(file, overwrite: overwrite);

    if (!shouldContinue) return;

    await ensureDirectory(file.parent);

    await generateTemplate(
      templateRoot: context.template.name,
      template: definition.template,
      output: path(context.featurePath, output),
      variables: context.naming.variables,
      overwrite: overwrite,
    );
  }
}
