import 'dart:io';

/// Locates the root directory of the installed FKIT package.
class PackageLocator {
  /// Creates a package locator.
  const PackageLocator();

  /// Resolves the root directory of the FKIT package.
  ///
  /// Uses the currently executing Dart script to determine the package
  /// installation location.
  Directory packageRoot() {
    final snapshot = File.fromUri(Platform.script);

    var dir = snapshot.parent;

    while (true) {
      final pubspec = File('${dir.path}/pubspec.yaml');
      if (pubspec.existsSync()) return dir;

      final parent = dir.parent;
      if (parent.path == dir.path) {
        throw Exception('Unable to locate flutter_devops_kit package root.');
      }

      dir = parent;
    }
  }
}
