import 'get_it_network_integrator.dart';
import 'module_integrator.dart';
import 'router_module_integrator.dart';

/// Provides access to the module integrators supported by FKIT.
class ModuleIntegratorRegistry {
  const ModuleIntegratorRegistry._();

  /// The registered module integrators keyed by integration strategy.
  ///
  /// Dependency injection-specific integrations use keys in the
  /// `di_strategy:integration_strategy` format.
  static const Map<String, ModuleIntegrator> integrators = {
// Generic integrations.
    'router': RouterModuleIntegrator(),

// DI-specific integrations.
    'get_it:network': GetItNetworkIntegrator(),
  };

  /// Resolves the module integrator for the specified strategies.
  ///
  /// Attempts to resolve a dependency injection-specific integrator using
  /// [diStrategy] and [integrationStrategy] before falling back to a generic
  /// integration strategy.
  ///
  /// Returns `null` when no matching integrator is registered.
  static ModuleIntegrator? resolve({
    required String diStrategy,
    required String integrationStrategy,
  }) {
    final diSpecificKey = '$diStrategy:$integrationStrategy';

    return integrators[diSpecificKey] ?? integrators[integrationStrategy];
  }
}
