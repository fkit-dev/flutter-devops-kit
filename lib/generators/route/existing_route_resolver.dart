import 'existing_route_status.dart';
import 'resolved_route.dart';
import 'route_import_resolver.dart';

class ExistingRouteResolver {
  const ExistingRouteResolver();

  List<ExistingRouteStatus> resolve(
      {required List<ResolvedRoute> discoveredRoutes,
      required String routeContent,
      required String routerContent,
      required String routerFile}) {
    final statuses = discoveredRoutes.map((route) {
      final importPath = const RouteImportResolver().resolve(routerFile: routerFile, screenFile: route.file);
      return ExistingRouteStatus(
        route: route,
        hasDefinition: _containsRouteDefinition(content: routeContent, route: route),
        hasImport: _containsImport(content: routerContent, importPath: importPath),
        hasRegistration: _containsRouterRegistration(content: routerContent, route: route),
      );
    });

    return statuses.where((status) => !status.isComplete).toList();
  }

  bool _containsRouteDefinition({required String content, required ResolvedRoute route}) {
    final pattern = RegExp('\\b${RegExp.escape(route.name)}\\s*\\(');
    return pattern.hasMatch(content);
  }

  bool _containsImport({required String content, required String importPath}) {
    final import = "import '$importPath';";
    return content.contains(import);
  }

  bool _containsRouterRegistration({required String content, required ResolvedRoute route}) {
    final pattern = RegExp('name\\s*:\\s*AppRoute\\.'
        '${RegExp.escape(route.name)}'
        '\\.routeName');
    return pattern.hasMatch(content);
  }
}
