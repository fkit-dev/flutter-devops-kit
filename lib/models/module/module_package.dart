/// Defines a package dependency required by an FKIT module.
class ModulePackage {
  /// Creates a module package configuration.
  const ModulePackage({
    required this.name,
    required this.version,
    this.when,
  });

  /// The name of the package.
  final String name;

  /// The version constraint of the package.
  final String version;

  /// The optional condition that determines whether the package is required.
  final String? when;

  /// Creates a module package from the provided [name] and configuration
  /// [value].
  ///
  /// The [value] may be either a package version or a map containing version
  /// and conditional configuration.
  factory ModulePackage.fromValue({
    required String name,
    required dynamic value,
  }) {
    if (value is Map) {
      final map = Map<dynamic, dynamic>.from(value);

      return ModulePackage(
        name: name,
        version: map['version']?.toString() ?? 'any',
        when: map['when']?.toString(),
      );
    }

    return ModulePackage(
      name: name,
      version: value?.toString() ?? 'any',
    );
  }

  /// Whether the package is included conditionally.
  bool get isConditional => when != null && when!.isNotEmpty;
}
