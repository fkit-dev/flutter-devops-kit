import 'dart:io';

import '../../models/module/module_file.dart';
import '../core/generator_mixin.dart';
import 'module_context.dart';

class ModuleGenerator with GeneratorMixin {
  const ModuleGenerator();

  Future<bool> generate(ModuleContext context, {bool overwrite = false}) async {
    if (!overwrite && await _moduleExists(context)) {
      overwrite =
          await confirmOverwrite('${context.module.displayName} module');
      if (!overwrite) return false;
    }
    await _generateFiles(context, overwrite: overwrite);
    return true;
  }

  Future<void> _generateFiles(ModuleContext context,
      {required bool overwrite}) async {
    for (final file in context.module.files) {
      if (!_shouldGenerate(context, file)) continue;
      final output = resolveVariables(file.output, context.variables);
      await generateTemplate(
          templateRoot: context.templateRoot,
          template: file.template,
          output: output,
          variables: context.variables,
          overwrite: overwrite);
    }
  }

  Future<bool> _moduleExists(ModuleContext context) async {
    for (final file in context.module.files) {
      if (!_shouldGenerate(context, file)) continue;
      final output = resolveVariables(file.output, context.variables);
      if (File(output).existsSync()) return true;
    }
    return false;
  }

  bool _shouldGenerate(ModuleContext context, ModuleFile file) {
    final condition = file.when;

    if (condition == null || condition.isEmpty) return true;
    return context.isEnabled(condition);
  }
}
