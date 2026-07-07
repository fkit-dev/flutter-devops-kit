import 'dart:io';

import '../../../services/logger_service.dart';
import '../../core/generator_context.dart';
import '../../core/generator_mixin.dart';
import '../existing_route_resolver.dart';
import '../resolved_route.dart';
import '../route_import_resolver.dart';

class GoRouterRenderer with GeneratorMixin {
  const GoRouterRenderer();

  static const _routeStartMarker = '// <fkit:routes>';
  static const _routeEndMarker = '// </fkit:routes>';

  static const _importStartMarker = '// <fkit:imports>';
  static const _importEndMarker = '// </fkit:imports>';

  Future<void> render({required GeneratorContext context, required List<ResolvedRoute> routes}) async {
    final router = context.template.router;

    final routeFile = File(router.routeFile);
    final routerFile = File(router.routerFile);

    if (!routeFile.existsSync()) throw Exception('Route file not found: ${routeFile.path}');
    if (!routerFile.existsSync()) throw Exception('Router file not found: ${routerFile.path}');

    final routeContent = await routeFile.readAsString();
    final routerContent = await routerFile.readAsString();

    final statuses = const ExistingRouteResolver().resolve(
      discoveredRoutes: routes,
      routeContent: routeContent,
      routerContent: routerContent,
      routerFile: router.routerFile,
    );

    if (statuses.isEmpty) {
      LoggerService.info('Routes already synchronized.');
      return;
    }
    LoggerService.info('Synchronizing ${statuses.length} route(s).');

    var updatedRouteContent = routeContent;
    var updatedRouterContent = routerContent;

    for (final status in statuses) {
      final route = status.route;
      LoggerService.info('  • ${route.name}');

      if (status.requiresDefinition) updatedRouteContent = _appendRouteDefinition(content: updatedRouteContent, route: route);
      if (status.requiresImport) {
        updatedRouterContent = _appendImport(
          content: updatedRouterContent,
          route: route,
          routerFile: router.routerFile,
        );
      }
      if (status.requiresRegistration) updatedRouterContent = _appendRouterRegistration(content: updatedRouterContent, route: route);
    }

    if (updatedRouteContent != routeContent) await writeFile(file: routeFile, content: updatedRouteContent, overwrite: true);
    if (updatedRouterContent != routerContent) await writeFile(file: routerFile, content: updatedRouterContent, overwrite: true);
  }

  String _appendRouteDefinition({
    required String content,
    required ResolvedRoute route,
  }) {
    _validateMarkers(
      content: content,
      startMarker: _routeStartMarker,
      endMarker: _routeEndMarker,
      fileName: 'route file',
    );

    final entry = "  ${route.name}('${route.path}'),";

    return _insertAfterStartMarker(
      content: content,
      startMarker: _routeStartMarker,
      value: entry,
    );
  }

  String _insertAfterStartMarker({
    required String content,
    required String startMarker,
    required String value,
  }) {
    final markerIndex = content.indexOf(startMarker);

    if (markerIndex == -1) {
      throw Exception(
        'FKIT marker not found: $startMarker',
      );
    }

    final insertIndex = markerIndex + startMarker.length;

    return content.replaceRange(
      insertIndex,
      insertIndex,
      '\n$value',
    );
  }

  String _appendImport({required String content, required ResolvedRoute route, required String routerFile}) {
    _validateMarkers(content: content, startMarker: _importStartMarker, endMarker: _importEndMarker, fileName: 'router imports');

    final importPath = const RouteImportResolver().resolve(routerFile: routerFile, screenFile: route.file);
    final import = "import '$importPath';";
    return _insertBeforeEndMarker(content: content, endMarker: _importEndMarker, value: import);
  }

  String _appendRouterRegistration({required String content, required ResolvedRoute route}) {
    _validateMarkers(content: content, startMarker: _routeStartMarker, endMarker: _routeEndMarker, fileName: 'router routes');
    final registration = '''
      GoRoute(
        path: AppRoute.${route.name}.path,
        name: AppRoute.${route.name}.routeName,
        builder: (_, _) => const ${route.className}(),
      ),''';
    return _insertBeforeEndMarker(content: content, endMarker: _routeEndMarker, value: registration);
  }

  String _insertBeforeEndMarker({required String content, required String endMarker, required String value}) {
    final index = content.indexOf(endMarker);
    if (index == -1) throw Exception('FKIT marker not found: $endMarker');

    return content.replaceRange(index, index, '$value\n\n');
  }

  void _validateMarkers({required String content, required String startMarker, required String endMarker, required String fileName}) {
    if (!content.contains(startMarker)) throw Exception('Missing FKIT start marker in $fileName: $startMarker');
    if (!content.contains(endMarker)) throw Exception('Missing FKIT end marker in $fileName: $endMarker');

    final startIndex = content.indexOf(startMarker);
    final endIndex = content.indexOf(endMarker);

    if (startIndex >= endIndex) throw Exception('Invalid FKIT marker order in $fileName.');
  }
}
