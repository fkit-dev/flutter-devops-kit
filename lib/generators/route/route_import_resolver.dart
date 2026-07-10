import 'dart:io';

import 'package:path/path.dart' as p;

/// Resolves relative import paths between router and screen files.
class RouteImportResolver {
  /// Creates a route import resolver.
  const RouteImportResolver();

  /// Resolves the relative import path from [routerFile] to [screenFile].
  ///
  /// Returns a normalized POSIX-style path suitable for use in Dart imports.
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
