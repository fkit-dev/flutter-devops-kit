class ModuleFile {
  final String template;
  final String output;

  /// Optional module option controlling whether
  /// this file should be generated.
  final String? when;

  const ModuleFile({required this.template, required this.output, this.when});

  factory ModuleFile.fromMap(Map<dynamic, dynamic> map) {
    return ModuleFile(
      template: map['template'].toString(),
      output: map['output'].toString(),
      when: map['when']?.toString(),
    );
  }

  bool get isConditional => when != null && when!.isNotEmpty;
}
