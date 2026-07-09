import 'package:dio/dio.dart';

import '../constants/header_key.dart';

typedef AccessTokenProvider = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required AccessTokenProvider tokenProvider,
  }) : _tokenProvider = tokenProvider;

  final AccessTokenProvider _tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _tokenProvider();

      if (token?.isNotEmpty == true) {
        options.headers[HeaderKey.authorization] =
            'Bearer $token';
      }
    } catch (_) {
      // Token resolution failures should not terminate the request.
    }

    handler.next(options);
  }
}