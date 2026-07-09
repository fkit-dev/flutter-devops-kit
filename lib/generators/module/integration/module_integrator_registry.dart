import 'get_it_network_integrator.dart';
import 'module_integrator.dart';

class ModuleIntegratorRegistry {
  const ModuleIntegratorRegistry._();

  static const Map<String, ModuleIntegrator> integrators = {
    'get_it:network': GetItNetworkIntegrator(),
  };
}
