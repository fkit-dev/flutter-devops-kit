import 'dart:io';

import '../core/generator_context.dart';
import 'resolved_route.dart';

class RouteResolver {
  const RouteResolver();

  Future<List<ResolvedRoute>> resolve(GeneratorContext context) async {
    final router = context.template.router;

    if (!router.enabled) return const [];
    final featuresDirectory = Directory(context.config.featureDir);

    if (!featuresDirectory.existsSync()) return const [];

    final routes = <ResolvedRoute>[];

    await for (final entity
        in featuresDirectory.list(recursive: true, followLinks: false)) {
      if (entity is! File) continue;

      final fileName = _fileName(entity.path);

      if (!fileName.endsWith(router.screenSuffix)) continue;

      if (_isIgnored(fileName, router.ignore)) continue;

      if (!_isInsideScreenFolder(entity.path, router.screenFolder)) continue;

      final routeName = _resolveRouteName(fileName, router.screenSuffix);

      routes.add(
        ResolvedRoute(
            name: _snakeToCamel(routeName),
            path: '/${routeName.replaceAll('_', '-')}',
            className: _snakeToPascal(fileName.replaceFirst('.dart', '')),
            file: entity.path),
      );
    }

    routes.sort((a, b) => a.path.compareTo(b.path));

    return routes;
  }

  bool _isInsideScreenFolder(String filePath, String screenFolder) {
    final normalizedFile = filePath.replaceAll('\\', '/');

    final normalizedFolder =
        screenFolder.replaceAll('\\', '/').replaceAll(RegExp(r'^/+|/+$'), '');

    return normalizedFile.contains('/$normalizedFolder/');
  }

  bool _isIgnored(String fileName, List<String> patterns) {
    for (final pattern in patterns) {
      final regex =
          RegExp('^${RegExp.escape(pattern).replaceAll(r'\*', '.*')}\$');
      if (regex.hasMatch(fileName)) return true;
    }
    return false;
  }

  String _resolveRouteName(String fileName, String suffix) {
    return fileName.substring(0, fileName.length - suffix.length);
  }

  String _fileName(String path) {
    return path.replaceAll('\\', '/').split('/').last;
  }

  String _snakeToCamel(String value) {
    final parts = value.split('_');

    return parts.first +
        parts.skip(1).map((part) {
          return part[0].toUpperCase() + part.substring(1);
        }).join();
  }

  String _snakeToPascal(String value) {
    return value.split('_').map((part) {
      return part[0].toUpperCase() + part.substring(1);
    }).join();
  }
}
