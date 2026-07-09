import 'dart:io';

class PackageLocator {
  const PackageLocator();

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
