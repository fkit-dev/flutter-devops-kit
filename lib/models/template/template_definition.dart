import 'template_barrel.dart';
import 'template_component.dart';
import 'template_di.dart';
import 'template_feature.dart';
import 'template_group.dart';
import 'template_module.dart';
import 'template_requirements.dart';
import 'template_router.dart';
import 'template_setup.dart';

class TemplateDefinition {
  const TemplateDefinition({
    required this.schema,
    required this.name,
    required this.setup,
    required this.requirements,
    required this.displayName,
    required this.description,
    required this.di,
    required this.barrel,
    required this.version,
    required this.author,
    required this.supports,
    required this.feature,
    required this.components,
    required this.groups,
    required this.router,
    required this.modules,
  });

  final int schema;
  final String name;
  final TemplateSetup setup;
  final TemplateRequirements requirements;
  final String displayName;
  final String description;
  final TemplateDi di;
  final TemplateBarrel barrel;
  final String version;
  final String author;
  final List<String> supports;
  final TemplateFeature feature;
  final Map<String, TemplateGroup> groups;
  final Map<String, TemplateComponent> components;
  final TemplateRouter router;
  final Map<String, TemplateModule> modules;

  factory TemplateDefinition.fromMap(Map<dynamic, dynamic> map) {
    final componentMap =
        Map<dynamic, dynamic>.from(map['components'] ?? const {});
    final groupMap = Map<dynamic, dynamic>.from(map['groups'] ?? const {});
    final moduleMap = Map<dynamic, dynamic>.from(map['modules'] ?? const {});
    return TemplateDefinition(
      schema: map['schema'] as int,
      name: map['name'] as String,
      displayName: map['display_name'] as String,
      setup: TemplateSetup.fromMap(
          Map<dynamic, dynamic>.from(map['setup'] ?? const {})),
      requirements: TemplateRequirements.fromMap(
          Map<dynamic, dynamic>.from(map['requires'] ?? const {})),
      description: map['description'] as String,
      di: TemplateDi.fromMap(Map<dynamic, dynamic>.from(map['di'] ?? const {})),
      barrel: TemplateBarrel.fromMap(
          Map<dynamic, dynamic>.from(map['barrel'] ?? const {})),
      version: map['version'].toString(),
      author: map['author'] as String,
      supports: List<String>.from(map['supports'] ?? const []),
      feature:
          TemplateFeature.fromMap(Map<dynamic, dynamic>.from(map['feature'])),
      modules: moduleMap.map((key, value) => MapEntry(key.toString(),
          TemplateModule.fromMap(Map<dynamic, dynamic>.from(value)))),
      groups: groupMap.map((key, value) => MapEntry(key.toString(),
          TemplateGroup.fromMap(Map<dynamic, dynamic>.from(value)))),
      router: TemplateRouter.fromMap(
          Map<dynamic, dynamic>.from(map['router'] ?? const {})),
      components: componentMap.map((key, value) => MapEntry(key.toString(),
          TemplateComponent.fromMap(Map<dynamic, dynamic>.from(value)))),
    );
  }
}
