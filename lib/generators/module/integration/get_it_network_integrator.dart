import 'dart:io';

import '../../core/generator_mixin.dart';
import '../module_context.dart';
import 'module_integrator.dart';

/// Integrates generated network module dependencies with GetIt.
///
/// Updates the project's dependency injection configuration with registrations
/// required by the generated network module.
class GetItNetworkIntegrator with GeneratorMixin implements ModuleIntegrator {
  /// Creates a GetIt network module integrator.
  const GetItNetworkIntegrator();

  @override
  Future<void> integrate(ModuleContext context) async {
    final file = File('lib/core/network/network_di.dart');

    final buffer = StringBuffer();

    _writeImports(buffer, context);
    _writeBody(buffer, context);

    await writeFile(
      file: file,
      content: buffer.toString(),
      overwrite: true,
    );
  }

  void _writeImports(
    StringBuffer buffer,
    ModuleContext context,
  ) {
    buffer.writeln(
      "import 'package:connectivity_plus/connectivity_plus.dart';",
    );
    buffer.writeln(
      "import 'package:dio/dio.dart';",
    );
    buffer.writeln(
      "import 'package:get_it/get_it.dart';",
    );

    if (context.isEnabled('talker_logger')) {
      buffer.writeln(
        "import 'package:flutter/foundation.dart';",
      );
    }

    buffer.writeln();
    buffer.writeln("import 'base_api_service.dart';");
    buffer.writeln("import 'network_api_service.dart';");
    buffer.writeln("import 'config/dio_factory.dart';");
    buffer.writeln(
      "import 'interceptors/auth_interceptor.dart';",
    );
    buffer.writeln(
      "import 'interceptors/network_interceptor.dart';",
    );

    if (context.isEnabled('talker_logger')) {
      buffer.writeln(
        "import 'interceptors/api_response_log_interceptor.dart';",
      );
    }

    buffer.writeln(
      "import 'services/network_monitor_service.dart';",
    );
  }

  void _writeBody(
    StringBuffer buffer,
    ModuleContext context,
  ) {
    buffer.writeln();
    buffer.writeln(
      'Future<void> initNetworkDependencies(GetIt sl) async {',
    );

    buffer.writeln('''
  sl.registerLazySingleton<Connectivity>(
    Connectivity.new,
  );

  sl.registerLazySingleton<NetworkMonitorService>(
    () => NetworkMonitorService(
      sl<Connectivity>(),
    ),
  );

  sl.registerLazySingleton<NetworkInterceptor>(
    () => NetworkInterceptor(
      sl<NetworkMonitorService>(),
    ),
  );

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(
      tokenProvider: () async => null,
    ),
  );

  sl.registerLazySingleton<Dio>(
    () => DioFactory.create(
      interceptors: [
        sl<NetworkInterceptor>(),
        sl<AuthInterceptor>(),''');

    if (context.isEnabled('talker_logger')) {
      buffer.writeln('''
        if (kDebugMode)
          ApiResponseLogInterceptor.create(),''');
    }

    buffer.writeln('''
      ],
    ),
  );

  sl.registerLazySingleton<BaseApiService>(
    () => NetworkApiService(
      sl<Dio>(),
    ),
  );
}''');
  }
}
