import 'dart:io';

import '../../analyzer/models/constructor_resolver.dart';
import '../core/generator_context.dart';
import '../core/template_renderer.dart';
import 'resolved_registration.dart';

/// Resolves dependency injection registrations for generated components.
class RegistrationResolver {
  /// Creates a registration resolver.
  const RegistrationResolver();

  /// Resolves dependency injection registrations using the provided [context].
  ///
  /// Returns the registrations derived from the template and generated
  /// component configuration.
  Future<List<ResolvedRegistration>> resolve(
    GeneratorContext context,
  ) async {
    final registrations = <ResolvedRegistration>[];

    for (final registration in context.template.di.allRegistrations) {
      final abstraction = context.naming.resolveClass(registration.component);
      final implementation = context.naming
          .resolveClass(registration.implementation ?? registration.component);
      final implementationComponent =
          registration.implementation ?? registration.component;

      final component = context.template.components[implementationComponent]!;
      final output = TemplateRenderer.renderString(
          component.output, context.naming.variables);
      final file = File('${context.featurePath}/$output');
      if (!file.existsSync()) continue;
      final parameters = await ConstructorResolver().resolve(file);
      /*for (final p in parameters) {
        print('Parameter: "${p.name}"');
      }*/
      registrations.add(ResolvedRegistration(
        lifecycle: registration.lifecycle,
        abstraction: abstraction,
        implementation: implementation,
        variable: context.naming.resolveVariable(registration.component),
        dependencies: parameters.map((e) => '${e.name}: sl()').toList(),
      ));
    }

    return registrations;
  }
}
