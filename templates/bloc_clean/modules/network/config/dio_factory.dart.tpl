import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';

class DioFactory {
  const DioFactory._();

  static Dio create({
    String? baseUrl,
    List<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? ApiConfig.baseUrl,
        headers: Map<String, dynamic>.from(
          ApiConfig.defaultHeaders,
        ),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        connectTimeout: ApiConfig.connectTimeout,
        sendTimeout: kIsWeb ? null : ApiConfig.sendTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        validateStatus: (status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
    );

    dio.interceptors.addAll(interceptors);

    return dio;
  }
}