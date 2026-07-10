import 'template_barrel.dart';
import 'template_component.dart';
import 'template_di.dart';
import 'template_feature.dart';
import 'template_group.dart';
import 'template_module.dart';
import 'template_requirements.dart';
import 'template_router.dart';
import 'template_setup.dart';

/// Defines the complete configuration and metadata of an FKIT template.
class TemplateDefinition {
  /// Creates a template definition.
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

  /// The schema version used by the template definition.
  final int schema;

  /// The unique name of the template.
  final String name;

  /// The project setup configuration for the template.
  final TemplateSetup setup;

  /// The package and generation requirements of the template.
  final TemplateRequirements requirements;

  /// The human-readable name of the template.
  final String displayName;

  /// A description of the template and its purpose.
  final String description;

  /// The dependency injection configuration of the template.
  final TemplateDi di;

  /// The barrel file generation configuration of the template.
  final TemplateBarrel barrel;

  /// The version of the template.
  final String version;

  /// The author of the template.
  final String author;

  /// The capabilities or architectures supported by the template.
  final List<String> supports;

  /// The feature generation configuration of the template.
  final TemplateFeature feature;

  /// The component groups defined by the template.
  final Map<String, TemplateGroup> groups;

  /// The components available for generation.
  final Map<String, TemplateComponent> components;

  /// The routing configuration of the template.
  final TemplateRouter router;

  /// The modules available in the template.
  final Map<String, TemplateModule> modules;

  /// Creates a template definition from the provided [map].
  factory TemplateDefinition.fromMap(Map<dynamic, dynamic> map) {
    final componentMap = Map<dynamic, dynamic>.from(map['components'] ?? const {});
    final groupMap = Map<dynamic, dynamic>.from(map['groups'] ?? const {});
    final moduleMap = Map<dynamic, dynamic>.from(map['modules'] ?? const {});

    return TemplateDefinition(
      schema: map['schema'] as int,
      name: map['name'] as String,
      displayName: map['display_name'] as String,
      setup: TemplateSetup.fromMap(
        Map<dynamic, dynamic>.from(map['setup'] ?? const {}),
      ),
      requirements: TemplateRequirements.fromMap(
        Map<dynamic, dynamic>.from(map['requires'] ?? const {}),
      ),
      description: map['description'] as String,
      di: TemplateDi.fromMap(
        Map<dynamic, dynamic>.from(map['di'] ?? const {}),
      ),
      barrel: TemplateBarrel.fromMap(
        Map<dynamic, dynamic>.from(map['barrel'] ?? const {}),
      ),
      version: map['version'].toString(),
      author: map['author'] as String,
      supports: List<String>.from(map['supports'] ?? const []),
      feature: TemplateFeature.fromMap(
        Map<dynamic, dynamic>.from(map['feature']),
      ),
      modules: moduleMap.map(
        (key, value) => MapEntry(
          key.toString(),
          TemplateModule.fromMap(
            Map<dynamic, dynamic>.from(value),
          ),
        ),
      ),
      groups: groupMap.map(
        (key, value) => MapEntry(
          key.toString(),
          TemplateGroup.fromMap(
            Map<dynamic, dynamic>.from(value),
          ),
        ),
      ),
      router: TemplateRouter.fromMap(
        Map<dynamic, dynamic>.from(map['router'] ?? const {}),
      ),
      components: componentMap.map(
        (key, value) => MapEntry(
          key.toString(),
          TemplateComponent.fromMap(
            Map<dynamic, dynamic>.from(value),
          ),
        ),
      ),
    );
  }
}
