import 'dart:io';

import '../core/generator_context.dart';
import '../core/generator_mixin.dart';

/// Generates individual components from FKIT template definitions.
class ComponentGenerator with GeneratorMixin {
  /// Creates a component generator.
  const ComponentGenerator();

  /// Generates the specified [component] using the provided [context].
  ///
  /// Existing generated files are replaced only when [overwrite] is `true`.
  Future<void> generate({
    required GeneratorContext context,
    required String component,
    bool overwrite = false,
  }) async {
    final definition = context.template.components[component];

    if (definition == null) {
      throw Exception(
          'Component "$component" is not supported by template "${context.template.name}".');
    }

    final output =
        resolveVariables(definition.output, context.naming.variables);

    final file = File(path(context.featurePath, output));

    final shouldContinue = await shouldGenerate(file, overwrite: overwrite);

    if (!shouldContinue) return;

    await ensureDirectory(file.parent);

    await generateTemplate(
        templateRoot: context.template.name,
        template: definition.template,
        output: path(context.featurePath, output),
        variables: context.naming.variables,
        overwrite: overwrite);
  }
}
