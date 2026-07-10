/// Defines a file generated during project bootstrapping.
class TemplateBootstrapFile {
  /// Creates a template bootstrap file configuration.
  const TemplateBootstrapFile({
    required this.template,
    required this.output,
  });

  /// The path to the source template file.
  final String template;

  /// The output path where the generated file is written.
  final String output;

  /// Creates a template bootstrap file configuration from the provided [map].
  factory TemplateBootstrapFile.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return TemplateBootstrapFile(
      template: map['template'].toString(),
      output: map['output'].toString(),
    );
  }
}
