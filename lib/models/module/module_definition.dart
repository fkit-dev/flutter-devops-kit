import 'module_file.dart';
import 'module_integration.dart';
import 'module_option.dart';
import 'module_requirements.dart';

class ModuleDefinition {
  const ModuleDefinition({
    required this.name,
    required this.displayName,
    required this.description,
    required this.version,
    required this.files,
    required this.requirements,
    required this.options,
    required this.integration,
  });

  final String name;
  final String displayName;
  final String description;
  final String version;
  final List<ModuleFile> files;
  final ModuleRequirements requirements;
  final Map<String, ModuleOption> options;
  final ModuleIntegration integration;

  factory ModuleDefinition.fromMap(Map<dynamic, dynamic> map) {
    final optionsMap = Map<dynamic, dynamic>.from(map['options'] ?? const {});

    return ModuleDefinition(
      name: map['name'].toString(),
      displayName: map['display_name'].toString(),
      description: map['description'].toString(),
      version: map['version'].toString(),
      files: (map['files'] as List)
          .map((e) => ModuleFile.fromMap(Map<dynamic, dynamic>.from(e)))
          .toList(),
      requirements: ModuleRequirements.fromMap(
          Map<dynamic, dynamic>.from(map['requires'] ?? const {})),
      options: optionsMap.map((key, value) => MapEntry(
          key.toString(),
          ModuleOption.fromMap(
              name: key.toString(), map: Map<dynamic, dynamic>.from(value)))),
      integration: ModuleIntegration.fromMap(
        Map<dynamic, dynamic>.from(
          map['integration'] ?? const {},
        ),
      ),
    );
  }

  bool get requiresBuildRunner => requirements.buildRunner;
  bool get requiresFlutterGen => requirements.flutterGen;
  bool get hasPackages => requirements.packages.isNotEmpty;
  bool get hasDevPackages => requirements.devPackages.isNotEmpty;
  bool get hasOptions => options.isNotEmpty;
  bool get requiresIntegration => integration.enabled;
}
