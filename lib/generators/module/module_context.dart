import '../../models/init_config.dart';
import '../../models/module/module_definition.dart';
import '../../models/module/module_package.dart';
import '../../models/template/template_definition.dart';
import 'module_variable_resolver.dart';

/// Provides configuration and resolved values used during module generation.
class ModuleContext {
  /// Creates a module generation context.
  const ModuleContext({
    required this.config,
    required this.template,
    required this.module,
    this.options = const {},
  });

  /// The project configuration used during module generation.
  final InitConfig config;

  /// The template associated with the module.
  final TemplateDefinition template;

  /// The module being generated or installed.
  final ModuleDefinition module;

  /// The configured module options keyed by option name.
  final Map<String, dynamic> options;

  /// The root path containing the module templates.
  String get templateRoot => '${template.name}/modules/${module.name}';

  /// The template variables available during module generation.
  Map<String, dynamic> get variables => const ModuleVariableResolver().resolve(this);

  /// The enabled runtime packages required by the module.
  ///
  /// Conditional packages are included only when their associated option is
  /// enabled.
  Map<String, String> get enabledPackages => _resolvePackages(module.requirements.packages);

  /// The enabled development packages required by the module.
  ///
  /// Conditional packages are included only when their associated option is
  /// enabled.
  Map<String, String> get enabledDevPackages => _resolvePackages(module.requirements.devPackages);

  /// Returns whether the specified module [option] is enabled.
  bool isEnabled(String option) => options[option] == true;

  Map<String, String> _resolvePackages(
    Map<String, ModulePackage> packages,
  ) {
    final resolved = <String, String>{};

    for (final package in packages.values) {
      if (!_isPackageEnabled(package)) continue;
      resolved[package.name] = package.version;
    }

    return resolved;
  }

  bool _isPackageEnabled(ModulePackage package) {
    if (!package.isConditional) return true;
    return isEnabled(package.when!);
  }
}
