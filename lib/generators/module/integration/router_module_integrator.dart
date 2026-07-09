import '../../core/generator_context.dart';
import '../../maintainers/route_maintainer.dart';
import '../module_context.dart';
import 'module_integrator.dart';

class RouterModuleIntegrator implements ModuleIntegrator {
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
