import '../../models/init_config.dart';
import '../../models/module/module_definition.dart';
import '../../models/module/module_package.dart';
import '../../models/template/template_definition.dart';

class ModuleContext {
  const ModuleContext(
      {required this.config,
      required this.template,
      required this.module,
      this.options = const {}});

  final InitConfig config;
  final TemplateDefinition template;
  final ModuleDefinition module;
  final Map<String, dynamic> options;

  String get templateRoot => '${template.name}/modules/${module.name}';
  Map<String, String> get variables => {'projectName': config.projectName};
  Map<String, String> get enabledPackages =>
      _resolvePackages(module.requirements.packages);
  Map<String, String> get enabledDevPackages =>
      _resolvePackages(module.requirements.devPackages);
  bool isEnabled(String option) => options[option] == true;

  Map<String, String> _resolvePackages(Map<String, ModulePackage> packages) {
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
