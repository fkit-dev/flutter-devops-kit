import '../generators/core/generator_context.dart';
import '../generators/maintainers/barrel_maintainer.dart';
import '../generators/maintainers/di_maintainer.dart';
import '../generators/maintainers/route_maintainer.dart';

/// Synchronizes generated project files after code generation.
///
/// Runs the configured maintainers to update barrel exports, dependency
/// injection registrations, and application routes.
class MaintenanceService {
  /// Creates a maintenance service.
  const MaintenanceService();

  /// Synchronizes generated project files using the provided [context].
  ///
  /// Updates barrel exports, dependency injection configuration, and route
  /// registrations to reflect the generated feature artifacts.
  Future<void> synchronize(GeneratorContext context) async {
    await BarrelMaintainer().maintain(context);
    await const DiMaintainer().maintain(context);
    await const RouteMaintainer().maintain(context);
  }
}
