import 'dart:io';

import '../core/generator_mixin.dart';
import 'module_context.dart';

class ModuleGenerator with GeneratorMixin {
  const ModuleGenerator();

  Future<void> generate(ModuleContext context, {bool overwrite = false}) async {
    if (!overwrite && await _moduleExists(context)) {
      overwrite = await confirmOverwrite('${context.module.displayName} module');
      if (!overwrite) return;
    }
    await _generateFiles(context, overwrite: overwrite);
  }

  Future<void> _generateFiles(ModuleContext context, {required bool overwrite}) async {
    for (final file in context.module.files) {
      final output = resolveVariables(file.output, context.variables);
      await generateTemplate(
          templateRoot: context.templateRoot, template: file.template, output: output, variables: const {}, overwrite: overwrite);
    }
  }

  Future<bool> _moduleExists(ModuleContext context) async {
    for (final file in context.module.files) {
      final output = resolveVariables(file.output, context.variables);
      if (File(output).existsSync()) return true;
    }
    return false;
  }
}
