/// Defines a group of related components in an FKIT template.
class TemplateGroup {
  /// Creates a template component group.
  const TemplateGroup({
    required this.description,
    required this.components,
  });

  /// A description of the component group.
  final String description;

  /// The components included in the group.
  final List<String> components;

  /// Creates a template component group from the provided [map].
  factory TemplateGroup.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return TemplateGroup(
      description: map['description']?.toString() ?? '',
      components: List<String>.from(
        map['components'] ?? const [],
      ),
    );
  }
}
