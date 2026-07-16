import 'module_option_type.dart';

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
  final ModuleOptionType type;

  /// The message displayed when prompting the user for the option value.
  final String prompt;

  /// The default value used when no option value is provided.
  final dynamic defaultValue;

  /// Creates a module option from the provided [name] and configuration [map].
  factory ModuleOption.fromMap({
    required String name,
    required Map<dynamic, dynamic> map,
  }) {
    final typeString = map['type']?.toString() ?? 'bool';

    return ModuleOption(
      name: name,
      type: ModuleOptionType.values.firstWhere(
        (e) => e.name == typeString,
        orElse: () => ModuleOptionType.bool,
      ),
      prompt: map['prompt']?.toString() ?? name,
      defaultValue: map['default'] ?? false,
    );
  }

  /// Whether the option is a string.
  bool get isString => type == ModuleOptionType.string;

  /// Whether the option is a boolean.
  bool get isBoolean => type == ModuleOptionType.bool;

  /// Whether the option is an integer.
  bool get isInteger => type == ModuleOptionType.int;

  /// Whether the option is a double.
  bool get isDouble => type == ModuleOptionType.double;

  /// Whether the option represents a color.
  bool get isColor => type == ModuleOptionType.color;

  /// Whether the option is an enumeration.
  bool get isEnum => type == ModuleOptionType.enumType;
}
