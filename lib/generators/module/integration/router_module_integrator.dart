import '../../core/generator_context.dart';
import '../../maintainers/route_maintainer.dart';
import '../module_context.dart';
import 'module_integrator.dart';

/// Integrates generated module routes into the project's routing configuration.
class RouterModuleIntegrator implements ModuleIntegrator {
  /// Creates a router module integrator.
  const RouterModuleIntegrator();

  @override
  Future<void> integrate(ModuleContext context) async {
    final generatorContext = GeneratorContext(
      config: context.config,
      feature: '',
      template: context.template,
    );

    await const RouteMaintainer().maintain(
      generatorContext,
    );
  }
}
