import 'template_file.dart';

class TemplateConfig {
  final List<String> folders;

  final List<TemplateFile> files;

  TemplateConfig({required this.folders, required this.files});

  factory TemplateConfig.fromMap(Map<dynamic, dynamic> map) {
    final folders = (map['folders'] as List).map((e) => e.toString()).toList();

    final files = (map['files'] as List).map((e) => TemplateFile(source: e['source'], destination: e['destination'])).toList();

    return TemplateConfig(folders: folders, files: files);
  }
}
