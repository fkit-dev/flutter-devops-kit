import 'package:path/path.dart' as p;

/// Provides utilities for working with file and directory paths.
class PathUtils {
  const PathUtils._();

  /// Returns the relative import path from one file to another.
  ///
  /// Path separators are normalized to forward slashes.
  static String relativeImport({
    required String from,
    required String to,
  }) {
    final fromDir = p.dirname(from);

    return p.relative(to, from: fromDir).replaceAll('\\', '/');
  }

  /// Normalizes [path] by replacing backslashes with forward slashes.
  static String normalize(String path) => path.replaceAll('\\', '/');

  /// Returns the file name portion of the specified [path].
  static String fileName(String path) => p.basename(path);

  /// Returns the directory portion of the specified [path].
  static String directory(String path) => p.dirname(path);
}
