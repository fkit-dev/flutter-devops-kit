import '../constants/header_key.dart';

class ApiConfig {
  const ApiConfig._();

  static const String baseUrl = '';

  static const Duration connectTimeout = Duration(
    seconds: 30,
  );

  static const Duration receiveTimeout = Duration(
    seconds: 30,
  );

  static const Duration sendTimeout = Duration(
    seconds: 30,
  );

  static const Map<String, dynamic> defaultHeaders = HeaderKey.defaultHeaders;
}