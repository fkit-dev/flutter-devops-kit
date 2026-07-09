import 'get_it_network_integrator.dart';
import 'module_integrator.dart';
import 'router_module_integrator.dart';

class ModuleIntegratorRegistry {
  const ModuleIntegratorRegistry._();

  static const Map<String, ModuleIntegrator> integrators = {
    // Generic integrations.
    'router': RouterModuleIntegrator(),

    // DI-specific integrations.
    'get_it:network': GetItNetworkIntegrator(),
  };

  static ModuleIntegrator? resolve({
    required String diStrategy,
    required String integrationStrategy,
  }) {
    final diSpecificKey = '$diStrategy:$integrationStrategy';

    return integrators[diSpecificKey] ?? integrators[integrationStrategy];
  }
}
