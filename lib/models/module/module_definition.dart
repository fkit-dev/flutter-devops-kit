import 'module_file.dart';
import 'module_requirements.dart';

class ModuleDefinition {
  const ModuleDefinition({
    required this.name,
    required this.displayName,
    required this.description,
    required this.version,
    required this.files,
    required this.requirements,
  });

  final String name;
  final String displayName;
  final String description;
  final String version;
  final List<ModuleFile> files;
  final ModuleRequirements requirements;

  factory ModuleDefinition.fromMap(Map<dynamic, dynamic> map) {
    return ModuleDefinition(
      name: map['name'].toString(),
      displayName: map['display_name'].toString(),
      description: map['description'].toString(),
      version: map['version'].toString(),
      files: (map['files'] as List).map((e) => ModuleFile.fromMap(Map<dynamic, dynamic>.from(e))).toList(),
      requirements: ModuleRequirements.fromMap(Map<dynamic, dynamic>.from(map['requires'] ?? const {})),
    );
  }

  bool get requiresBuildRunner => requirements.buildRunner;
  bool get requiresFlutterGen => requirements.flutterGen;
  bool get hasPackages => requirements.packages.isNotEmpty;
  bool get hasDevPackages => requirements.devPackages.isNotEmpty;
}
