/// Defines a configurable option exposed by an FKIT module.
class ModuleOption {
  /// Creates a module option configuration.
  const ModuleOption({
    required this.name,
    required this.type,
    required this.prompt,
    required this.defaultValue,
  });

  /// The unique name of the module option.
  final String name;

  /// The data type of the option.
  final String type;

  /// The message displayed when prompting the user for the option value.
  final String prompt;

  /// The default value used when no option value is provided.
  final dynamic defaultValue;

  /// Creates a module option from the provided [name] and configuration [map].
  factory ModuleOption.fromMap({
    required String name,
    required Map<dynamic, dynamic> map,
  }) {
    return ModuleOption(
      name: name,
      type: map['type']?.toString() ?? 'boolean',
      prompt: map['prompt']?.toString() ?? name,
      defaultValue: map['default'] ?? false,
    );
  }

  /// Whether the option uses the boolean data type.
  bool get isBoolean => type == 'boolean';
}
