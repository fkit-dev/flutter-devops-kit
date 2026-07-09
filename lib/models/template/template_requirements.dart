class TemplateRequirements {
  const TemplateRequirements({
    required this.packages,
    required this.devPackages,
    required this.flutterGen,
    required this.buildRunner,
  });

  final Map<String, String> packages;
  final Map<String, String> devPackages;
  final bool flutterGen;
  final bool buildRunner;

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

  const TemplateRequirements.empty()
      : packages = const {},
        devPackages = const {},
        flutterGen = false,
        buildRunner = false;

  bool get hasPackages => packages.isNotEmpty;

  bool get hasDevPackages => devPackages.isNotEmpty;
}
