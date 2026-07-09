class ModulePackage {
  const ModulePackage({required this.name, required this.version, this.when});

  final String name;
  final String version;
  final String? when;

  factory ModulePackage.fromValue(
      {required String name, required dynamic value}) {
    if (value is Map) {
      final map = Map<dynamic, dynamic>.from(value);
      return ModulePackage(
          name: name,
          version: map['version']?.toString() ?? 'any',
          when: map['when']?.toString());
    }
    return ModulePackage(name: name, version: value?.toString() ?? 'any');
  }

  bool get isConditional => when != null && when!.isNotEmpty;
}
