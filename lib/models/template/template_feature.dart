import 'template_file.dart';

/// Defines the folders and files generated for an FKIT feature.
class TemplateFeature {
  /// Creates a template feature configuration.
  const TemplateFeature({
    required this.folders,
    required this.files,
  });

  /// The directories created for the generated feature.
  final List<String> folders;

  /// The template files generated for the feature.
  final List<TemplateFile> files;

  /// Creates a template feature configuration from the provided [map].
  factory TemplateFeature.fromMap(Map<dynamic, dynamic> map) {
    return TemplateFeature(
      folders: List<String>.from(map['folders'] ?? const []),
      files: (map['files'] as List<dynamic>? ?? const [])
          .map(
            (e) => TemplateFile.fromMap(
              Map<dynamic, dynamic>.from(e),
            ),
          )
          .toList(),
    );
  }
}
