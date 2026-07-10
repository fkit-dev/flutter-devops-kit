/// Defines a code-generation component in an FKIT template.
class TemplateComponent {
  /// Creates a template component configuration.
  const TemplateComponent({
    required this.template,
    required this.description,
    required this.output,
  });

  /// The path to the source template file.
  final String template;

  /// A description of the generated component.
  final String description;

  /// The output path for the generated component.
  final String output;

  /// Creates a template component configuration from the provided [map].
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
