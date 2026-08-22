import 'dart:io';

/// Locates the root directory of the installed FKIT package.
class PackageLocator {
  /// Creates a package locator.
  const PackageLocator();

  static Directory? _cachedRoot;

  /// Resolves the root directory of the FKIT package.
  ///
  /// Uses the currently executing Dart script to determine the package
  /// installation location.
  Directory packageRoot() {
    final cached = _cachedRoot;
    if (cached != null && _isPackageRoot(cached)) return cached;

    final snapshot = File.fromUri(Platform.script);

    final scriptRoot = _findRoot(snapshot.parent);
    if (scriptRoot != null) return _cachedRoot = scriptRoot;

    final workingDirectoryRoot = _findRoot(Directory.current);
    if (workingDirectoryRoot != null) return _cachedRoot = workingDirectoryRoot;

    throw Exception('Unable to locate flutter_devops_kit package root.');
  }

  Directory? _findRoot(Directory start) {
    var dir = start;

    while (true) {
      if (_isPackageRoot(dir)) {
        return dir;
      }

      final parent = dir.parent;
      if (parent.path == dir.path) {
        return null;
      }

      dir = parent;
    }
  }

  bool _isPackageRoot(Directory directory) {
    return File('${directory.path}/pubspec.yaml').existsSync() &&
        Directory('${directory.path}/templates').existsSync();
  }
}
