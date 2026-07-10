import 'module_package.dart';

/// Defines the package and code-generation requirements of an FKIT module.
class ModuleRequirements {
  /// Creates module requirements with the specified configuration.
  const ModuleRequirements({
    required this.packages,
    required this.devPackages,
    required this.flutterGen,
    required this.buildRunner,
  });

  /// The runtime packages required by the module.
  final Map<String, ModulePackage> packages;

  /// The development packages required by the module.
  final Map<String, ModulePackage> devPackages;

  /// Whether Flutter code generation is required.
  final bool flutterGen;

  /// Whether build runner execution is required.
  final bool buildRunner;

  /// Creates module requirements from the provided [map].
  factory ModuleRequirements.fromMap(Map<dynamic, dynamic> map) {
    return ModuleRequirements(
      packages: _parsePackages(map['packages']),
      devPackages: _parsePackages(map['dev_packages']),
      flutterGen: map['flutter_gen'] ?? false,
      buildRunner: map['build_runner'] ?? false,
    );
  }

  /// Creates an empty module requirements configuration.
  const ModuleRequirements.empty()
      : packages = const {},
        devPackages = const {},
        flutterGen = false,
        buildRunner = false;

  static Map<String, ModulePackage> _parsePackages(dynamic value) {
    if (value == null) return const {};

    final map = Map<dynamic, dynamic>.from(value);

    return map.map(
      (key, value) {
        final name = key.toString();

        return MapEntry(
          name,
          ModulePackage.fromValue(
            name: name,
            value: value,
          ),
        );
      },
    );
  }
}
