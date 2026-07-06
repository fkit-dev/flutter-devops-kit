class ConstructorParameter {
  const ConstructorParameter({
    required this.type,
    required this.name,
    required this.isNamed,
    required this.isRequired,
  });

  final String type;

  final String name;

  final bool isNamed;

  final bool isRequired;
}
