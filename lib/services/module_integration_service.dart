import '../generators/module/integration/module_integrator_registry.dart';
import '../generators/module/module_context.dart';
/// Integrates generated modules into an FKIT project.
///
/// Resolves the appropriate module integrator based on the configured
/// dependency injection and integration strategies.
class ModuleIntegrationService {
  /// Creates a module integration service.
  const ModuleIntegrationService();

  /// Integrates the module described by the provided [context].
  ///
  /// Skips integration when it is disabled in the module configuration.
  /// Otherwise, resolves and executes the appropriate module integrator.
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
