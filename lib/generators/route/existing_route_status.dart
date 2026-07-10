import 'resolved_route.dart';

/// Describes the integration status of an existing application route.
class ExistingRouteStatus {
  /// Creates a route integration status.
  const ExistingRouteStatus({
    required this.route,
    required this.hasDefinition,
    required this.hasImport,
    required this.hasRegistration,
  });

  /// The resolved route associated with this status.
  final ResolvedRoute route;

  /// Whether the route definition already exists.
  final bool hasDefinition;

  /// Whether the route import already exists.
  final bool hasImport;

  /// Whether the route registration already exists.
  final bool hasRegistration;

  /// Whether the route definition and registration are both present.
  bool get isComplete => hasDefinition && hasRegistration;

  /// Whether the route definition needs to be added.
  bool get requiresDefinition => !hasDefinition;

  /// Whether the route import needs to be added.
  bool get requiresImport => !hasImport && !hasRegistration;

  /// Whether the route registration needs to be added.
  bool get requiresRegistration => !hasRegistration;
}
