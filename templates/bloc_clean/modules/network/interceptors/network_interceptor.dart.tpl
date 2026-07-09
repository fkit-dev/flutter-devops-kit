import 'package:dio/dio.dart';

import '../services/network_monitor_service.dart';

class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this._networkMonitorService);

  final NetworkMonitorService _networkMonitorService;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await _networkMonitorService.isConnected();

    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection.',
        ),
      );
    }

    handler.next(options);
  }
}