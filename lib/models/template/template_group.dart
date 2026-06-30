class TemplateGroup {
  const TemplateGroup({
    required this.description,
    required this.components,
  });

  final String description;
  final List<String> components;

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
