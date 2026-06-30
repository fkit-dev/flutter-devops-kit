import 'template_component.dart';
import 'template_feature.dart';

class TemplateDefinition {
  const TemplateDefinition({
    required this.name,
    required this.displayName,
    required this.description,
    required this.version,
    required this.author,
    required this.supports,
    required this.feature,
    required this.components,
    required this.groups,
  });

  final String name;
  final String displayName;
  final String description;
  final String version;
  final String author;

  final List<String> supports;

  final TemplateFeature feature;
  final Map<String, List<String>> groups;
  final Map<String, TemplateComponent> components;

  factory TemplateDefinition.fromMap(Map<dynamic, dynamic> map) {
    final componentMap = Map<dynamic, dynamic>.from(map['components'] ?? const {});
    final groupMap = Map<dynamic, dynamic>.from(map['groups'] ?? const {});

    return TemplateDefinition(
      name: map['name'] as String,
      displayName: map['display_name'] as String,
      description: map['description'] as String,
      version: map['version'].toString(),
      author: map['author'] as String,
      supports: List<String>.from(map['supports'] ?? const []),
      feature: TemplateFeature.fromMap(Map<dynamic, dynamic>.from(map['feature'])),
      groups: groupMap.map((key, value) => MapEntry(key.toString(), List<String>.from(value))),
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
