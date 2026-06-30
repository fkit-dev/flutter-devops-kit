class TemplateComponent {
  const TemplateComponent({
    required this.template,
    required this.output,
  });

  final String template;
  final String output;

  factory TemplateComponent.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return TemplateComponent(
      template: map['template'] as String,
      output: map['output'] as String,
    );
  }
}
