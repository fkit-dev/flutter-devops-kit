import 'dart:io';

import '../../utils/path_utils.dart';
import '../core/generator_context.dart';

class ImportResolver {
  const ImportResolver();

  Future<List<String>> resolve(
      {required GeneratorContext context, required String outputFile}) async {
    final imports = <String>{};

    final di = context.template.di;

    for (final folder in di.imports) {
      final directory = Directory('${context.featurePath}/$folder');

      if (!directory.existsSync()) continue;

      final files = directory
          .listSync(recursive: false)
          .whereType<File>()
          .where((file) => _isValid(file, di.ignore))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

      for (final file in files) {
        imports.add(PathUtils.relativeImport(from: outputFile, to: file.path));
      }
    }
    return imports.toList()..sort();
  }

  bool _isValid(File file, List<String> ignore) {
    final name = PathUtils.fileName(file.path);
    for (final pattern in ignore) {
      if (_matches(name, pattern)) return false;
    }
    return name.endsWith('.dart');
  }

  bool _matches(String value, String pattern) {
    if (pattern.startsWith('*')) return value.endsWith(pattern.substring(1));
    return value == pattern;
  }
}
