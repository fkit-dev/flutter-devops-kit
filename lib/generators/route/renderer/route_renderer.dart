import '../../core/generator_context.dart';
import '../resolved_route.dart';

/// Defines the contract for rendering application routes.
///
/// Implementations integrate resolved routes into the project's routing
/// configuration.
abstract interface class RouteRenderer {
  /// Renders resolved routes using the provided generation configuration.
  Future<void> render(
      {required GeneratorContext context, required List<ResolvedRoute> routes});
}
