import '../../models/init_config.dart';
import '../../models/module/module_definition.dart';
import '../../models/template/template_definition.dart';

class ModuleContext {
  const ModuleContext({required this.config, required this.template, required this.module});

  final InitConfig config;
  final TemplateDefinition template;
  final ModuleDefinition module;

  String get templateRoot => '${template.name}/modules/${module.name}';
  Map<String, String> get variables => {'projectName': config.projectName};
}
