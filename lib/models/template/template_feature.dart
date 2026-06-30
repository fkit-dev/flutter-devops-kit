import 'template_file.dart';

class TemplateFeature {
  const TemplateFeature({required this.folders, required this.files});

  final List<String> folders;
  final List<TemplateFile> files;

  factory TemplateFeature.fromMap(Map<dynamic, dynamic> map) {
    return TemplateFeature(
      folders: List<String>.from(map['folders'] ?? const []),
      files: (map['files'] as List<dynamic>? ?? const []).map((e) => TemplateFile.fromMap(Map<dynamic, dynamic>.from(e))).toList(),
    );
  }
}
