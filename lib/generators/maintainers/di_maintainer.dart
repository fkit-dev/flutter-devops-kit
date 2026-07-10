import 'dart:io';

import '../../models/template/registration_lifecycle.dart';
import '../core/generator_context.dart';
import '../core/generator_mixin.dart';
import '../feature/registration_resolver.dart';
import '../feature/resolved_registration.dart';
import 'import_resolver.dart';
import 'maintainer.dart';

/// Maintains dependency injection configuration for generated features.
///
/// Synchronizes dependency registrations and related imports using the
/// selected template configuration.
class DiMaintainer with GeneratorMixin implements Maintainer {
  /// Creates a dependency injection maintainer.
  const DiMaintainer();

  @override
  Future<void> maintain(GeneratorContext context) async {
    final di = context.template.di;

    if (!di.enabled || !di.isGetIt) return;

    final output = path(context.featurePath, resolveVariables(di.file, context.naming.variables));

    final imports = await const ImportResolver().resolve(context: context, outputFile: output);

    final registrations = await const RegistrationResolver().resolve(context);

    final buffer = StringBuffer();

    _writeHeader(buffer);
    _writeImports(buffer, imports);
    _writeBody(buffer, context, registrations);

    await writeFile(file: File(output), content: buffer.toString(), overwrite: true);
  }

  void _writeHeader(StringBuffer buffer) {
    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln();
    buffer.writeln("import 'package:get_it/get_it.dart';");
  }

  void _writeImports(StringBuffer buffer, List<String> imports) {
    buffer.writeln();

    for (final import in imports) {
      buffer.writeln("import '$import';");
    }
  }

  void _writeBody(StringBuffer buffer, GeneratorContext context, List<ResolvedRegistration> registrations) {
    buffer.writeln();
    buffer.writeln('final GetIt sl = GetIt.instance;');
    buffer.writeln();

    buffer.writeln('Future<void> init${context.naming.featurePascal}Dependencies() async {');

    for (final registration in registrations) {
      _writeRegistration(buffer, registration);
    }

    buffer.writeln('}');
  }

  void _writeRegistration(StringBuffer buffer, ResolvedRegistration registration) {
    final constructor = registration.dependencies.isEmpty
        ? '${registration.implementation}()'
        : ['${registration.implementation}(', ...registration.dependencies.map((e) => '  $e,'), ')'].join('\n');

    switch (registration.lifecycle) {
      case RegistrationLifecycle.factory:
        buffer.writeln('''
                        sl.registerFactory(
                          () => $constructor,
                        );
                      
                      ''');
        break;

      case RegistrationLifecycle.lazySingleton:
        buffer.writeln('''
                        sl.registerLazySingleton<${registration.abstraction}>(
                          () => $constructor,
                        );
                      
                      ''');
        break;

      case RegistrationLifecycle.singleton:
        buffer.writeln('''
                      sl.registerSingleton<${registration.abstraction}>(
                        $constructor,
                      );
                    
                    ''');
        break;
    }
  }
}
