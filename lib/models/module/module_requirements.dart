import 'module_package.dart';

class ModuleRequirements {
  const ModuleRequirements(
      {required this.packages,
      required this.devPackages,
      required this.flutterGen,
      required this.buildRunner});

  final Map<String, ModulePackage> packages;
  final Map<String, ModulePackage> devPackages;

  final bool flutterGen;
  final bool buildRunner;

  factory ModuleRequirements.fromMap(Map<dynamic, dynamic> map) {
    return ModuleRequirements(
        packages: _parsePackages(map['packages']),
        devPackages: _parsePackages(map['dev_packages']),
        flutterGen: map['flutter_gen'] ?? false,
        buildRunner: map['build_runner'] ?? false);
  }

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
            name, ModulePackage.fromValue(name: name, value: value));
      },
    );
  }
}
