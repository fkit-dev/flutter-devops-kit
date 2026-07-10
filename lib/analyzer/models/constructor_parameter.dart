/// Represents a parameter declared in a Dart constructor.
///
/// Contains metadata about the parameter's type, name, and whether it is
/// named or required.
class ConstructorParameter {
  /// Creates a constructor parameter description.
  const ConstructorParameter({
    required this.type,
    required this.name,
    required this.isNamed,
    required this.isRequired,
  });

  /// The declared Dart type of the parameter.
  final String type;

  /// The name of the parameter.
  final String name;

  /// Whether the parameter is a named parameter.
  final bool isNamed;

  /// Whether the parameter is required.
  final bool isRequired;
}
