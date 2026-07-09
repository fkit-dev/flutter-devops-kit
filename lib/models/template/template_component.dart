class TemplateComponent {
  const TemplateComponent({
    required this.template,
    required this.description,
    required this.output,
  });

  final String template;
  final String description;
  final String output;

  factory TemplateComponent.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return TemplateComponent(
      description: map['description'] as String,
      template: map['template'] as String,
      output: map['output'] as String,
    );
  }
}
