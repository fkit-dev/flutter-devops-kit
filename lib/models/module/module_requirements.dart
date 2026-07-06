class ModuleRequirements {
  const ModuleRequirements({required this.packages, required this.devPackages, required this.flutterGen, required this.buildRunner});

  final Map<String, String> packages;
  final Map<String, String> devPackages;
  final bool flutterGen;
  final bool buildRunner;

  factory ModuleRequirements.fromMap(Map<dynamic, dynamic> map) {
    return ModuleRequirements(
        packages: Map<String, String>.from(map['packages'] ?? const {}),
        devPackages: Map<String, String>.from(map['dev_packages'] ?? const {}),
        flutterGen: map['flutter_gen'] ?? false,
        buildRunner: map['build_runner'] ?? false);
  }

  const ModuleRequirements.empty()
      : packages = const {},
        devPackages = const {},
        flutterGen = false,
        buildRunner = false;
}
