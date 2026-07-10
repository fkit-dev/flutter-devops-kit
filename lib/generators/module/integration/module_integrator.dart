import '../module_context.dart';

/// Defines the contract for integrating generated modules into a project.
///
/// Implementations perform integration tasks based on the provided module
/// generation context.
abstract class ModuleIntegrator {
  /// Creates a module integrator.
  const ModuleIntegrator();

  /// Integrates a generated module using the provided [context].
  Future<void> integrate(ModuleContext context);
}
