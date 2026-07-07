import 'dart:io';

import 'package:path/path.dart' as p;

class RouteImportResolver {
  const RouteImportResolver();

  String resolve({
    required String routerFile,
    required String screenFile,
  }) {
    final router = File(routerFile);
    final screen = File(screenFile);

    final relativePath = p.relative(
      screen.absolute.path,
      from: router.parent.absolute.path,
    );

    return p.posix.normalize(relativePath);
  }
}
