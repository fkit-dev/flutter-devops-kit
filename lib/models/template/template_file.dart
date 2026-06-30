class TemplateFile {
  const TemplateFile({required this.template, required this.output});

  final String template;
  final String output;

  factory TemplateFile.fromMap(Map<dynamic, dynamic> map) {
    return TemplateFile(template: map['template'] as String, output: map['output'] as String);
  }
}
