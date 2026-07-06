class ModuleFile {
  const ModuleFile({required this.template, required this.output});

  final String template;
  final String output;

  factory ModuleFile.fromMap(Map<dynamic, dynamic> map) {
    return ModuleFile(template: map['template'].toString(), output: map['output'].toString());
  }
}
