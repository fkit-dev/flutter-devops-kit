import 'module_context.dart';

/// Resolves template variables for module generation.
///
/// In addition to exposing user-provided module options, this resolver also
/// computes derived variables that simplify template rendering.
class ModuleVariableResolver {
  /// Creates a module variable resolver.
  const ModuleVariableResolver();

  /// Resolves template variables for the provided [context].
  Map<String, dynamic> resolve(ModuleContext context) {
    final variables = <String, dynamic>{
      'projectName': context.config.projectName,
      ...context.options,
    };

    switch (context.module.name) {
      case 'theme':
        _resolveThemeVariables(variables);
        break;
    }

    return variables;
  }

  void _resolveThemeVariables(
    Map<String, dynamic> variables,
  ) {
    final secondary = variables['secondary_color'];

    variables['secondary_is_custom'] = secondary != null &&
        secondary.toString().isNotEmpty &&
        secondary != 'auto';
    variables['secondary_is_generated'] =
        !(variables['secondary_is_custom'] == true);
    variables['has_dark_theme'] = variables['enable_dark_theme'] == true;
    variables['has_gradient'] = variables['generate_gradient'] == true;
    variables['has_light_only_theme'] = !(variables['has_dark_theme'] == true);
    variables['no_dark_theme'] = !(variables['has_dark_theme'] == true);
  }
}
