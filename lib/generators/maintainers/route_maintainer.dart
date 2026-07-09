import '../../services/logger_service.dart';
import '../core/generator_context.dart';
import '../route/renderer/go_router_renderer.dart';
import '../route/resolved_route.dart';
import '../route/route_resolver.dart';
import 'maintainer.dart';

class RouteMaintainer implements Maintainer {
  const RouteMaintainer();

  @override
  Future<void> maintain(GeneratorContext context) async {
    final router = context.template.router;
    if (!router.enabled) return;

    final routes = await const RouteResolver().resolve(context);
    LoggerService.info('Discovered ${routes.length} routes.');

    for (final route in routes) {
      LoggerService.info('  • ${route.name} -> ${route.file}');
    }

    _validateRoutes(routes);

    if (router.isGoRouter) {
      await const GoRouterRenderer().render(context: context, routes: routes);
      return;
    }

    throw UnsupportedError('Unsupported router strategy "${router.strategy}".');
  }

  void _validateRoutes(List<ResolvedRoute> routes) {
    final names = <String>{};
    final paths = <String>{};

    for (final route in routes) {
      if (!names.add(route.name)) {
        throw Exception('Duplicate route name "${route.name}".');
      }
      if (!paths.add(route.path)) {
        throw Exception('Duplicate route path "${route.path}".');
      }
    }
  }
}
