class TemplateBootstrapFile {
  const TemplateBootstrapFile({
    required this.template,
    required this.output,
  });

  final String template;
  final String output;

  factory TemplateBootstrapFile.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return TemplateBootstrapFile(
      template: map['template'].toString(),
      output: map['output'].toString(),
    );
  }
}
