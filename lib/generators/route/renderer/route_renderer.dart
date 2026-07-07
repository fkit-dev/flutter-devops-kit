import '../../core/generator_context.dart';
import '../resolved_route.dart';

abstract interface class RouteRenderer {
  Future<void> render({required GeneratorContext context, required List<ResolvedRoute> routes});
}
