class ModuleOption {
  const ModuleOption(
      {required this.name,
      required this.type,
      required this.prompt,
      required this.defaultValue});

  final String name;
  final String type;
  final String prompt;
  final dynamic defaultValue;

  factory ModuleOption.fromMap(
      {required String name, required Map<dynamic, dynamic> map}) {
    return ModuleOption(
        name: name,
        type: map['type']?.toString() ?? 'boolean',
        prompt: map['prompt']?.toString() ?? name,
        defaultValue: map['default'] ?? false);
  }

  bool get isBoolean => type == 'boolean';
}
