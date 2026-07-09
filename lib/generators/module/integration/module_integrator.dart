import '../module_context.dart';

abstract class ModuleIntegrator {
  const ModuleIntegrator();

  Future<void> integrate(ModuleContext context);
}
