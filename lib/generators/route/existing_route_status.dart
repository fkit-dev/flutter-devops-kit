import 'resolved_route.dart';

class ExistingRouteStatus {
  const ExistingRouteStatus({required this.route, required this.hasDefinition, required this.hasImport, required this.hasRegistration});

  final ResolvedRoute route;
  final bool hasDefinition;
  final bool hasImport;
  final bool hasRegistration;

  bool get isComplete => hasDefinition && hasRegistration;
  bool get requiresDefinition => !hasDefinition;
  bool get requiresImport => !hasImport && !hasRegistration;
  bool get requiresRegistration => !hasRegistration;
}
