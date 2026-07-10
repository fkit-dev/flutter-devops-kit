/// Defines a template file and its generated output location.
class TemplateFile {
  /// Creates a template file configuration.
  const TemplateFile({
    required this.template,
    required this.output,
  });

  /// The path to the source template file.
  final String template;

  /// The output path where the generated file is written.
  final String output;

  /// Creates a template file configuration from the provided [map].
  factory TemplateFile.fromMap(Map<dynamic, dynamic> map) {
    return TemplateFile(
      template: map['template'] as String,
      output: map['output'] as String,
    );
  }
}
