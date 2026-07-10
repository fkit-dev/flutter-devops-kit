/// Defines the package and generation requirements of an FKIT template.
class TemplateRequirements {
  /// Creates template requirements with the specified configuration.
  const TemplateRequirements({
    required this.packages,
    required this.devPackages,
    required this.flutterGen,
    required this.buildRunner,
  });

  /// The runtime packages required by the template.
  final Map<String, String> packages;

  /// The development packages required by the template.
  final Map<String, String> devPackages;

  /// Whether Flutter code generation is required.
  final bool flutterGen;

  /// Whether build runner execution is required.
  final bool buildRunner;

  /// Creates template requirements from the provided configuration [map].
  factory TemplateRequirements.fromMap(Map<dynamic, dynamic> map) {
    return TemplateRequirements(
      packages: Map<String, String>.from(
        map['packages'] ?? const {},
      ),
      devPackages: Map<String, String>.from(
        map['dev_packages'] ?? const {},
      ),
      flutterGen: map['flutter_gen'] ?? false,
      buildRunner: map['build_runner'] ?? false,
    );
  }

  /// Creates an empty template requirements configuration.
  const TemplateRequirements.empty()
      : packages = const {},
        devPackages = const {},
        flutterGen = false,
        buildRunner = false;

  /// Whether the template requires runtime packages.
  bool get hasPackages => packages.isNotEmpty;

  /// Whether the template requires development packages.
  bool get hasDevPackages => devPackages.isNotEmpty;
}
