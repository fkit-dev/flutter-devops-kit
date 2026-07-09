import 'package:path/path.dart' as p;

class PathUtils {
  const PathUtils._();

  /// Returns relative import path from one file to another.
  static String relativeImport({required String from, required String to}) {
    final fromDir = p.dirname(from);

    return p.relative(to, from: fromDir).replaceAll('\\', '/');
  }

  static String normalize(String path) => path.replaceAll('\\', '/');

  static String fileName(String path) => p.basename(path);

  static String directory(String path) => p.dirname(path);
}
