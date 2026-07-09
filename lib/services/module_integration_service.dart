import '../generators/module/integration/module_integrator_registry.dart';
import '../generators/module/module_context.dart';

class ModuleIntegrationService {
  const ModuleIntegrationService();

  Future<void> integrate(ModuleContext context) async {
    final integration = context.module.integration;

    if (!integration.enabled) {
      return;
    }

    final integrator = ModuleIntegratorRegistry.resolve(
      diStrategy: context.template.di.strategy,
      integrationStrategy: integration.strategy,
    );

    if (integrator == null) {
      throw UnsupportedError(
        'Module integration not supported for '
        'DI strategy "${context.template.di.strategy}" '
        'and module strategy "${integration.strategy}".',
      );
    }

    await integrator.integrate(context);
  }
}
