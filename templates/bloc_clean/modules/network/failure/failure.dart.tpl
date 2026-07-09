import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exception.dart';
import 'error_model.dart';

class Failure {
  const Failure._();

  static AppException handleDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return TimeoutError();

      case DioExceptionType.badCertificate:
        return const HandshakeError();

      case DioExceptionType.connectionError:
        return const NoInternetError();

      case DioExceptionType.cancel:
        return const AppException(
          0,
          'Request cancelled',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      case DioExceptionType.unknown:
        return _handleUnknownError(exception);
    }
  }

  static AppException _handleBadResponse(
    DioException exception,
  ) {
    final response = exception.response;

    if (response == null) {
      return const UnknownError();
    }

    final statusCode = response.statusCode ?? 0;
    final message = _extractMessage(response);
    final error = _extractError(response);

    switch (statusCode) {
      case 400:
        return BadRequestError(
          statusCode: statusCode,
          message: message,
        );

      case 401:
        if (_isTokenExpired(response)) {
          return const SessionExpiry();
        }

        return UnauthorizedError(
          statusCode: statusCode,
          message: message,
        );

      case 403:
        return ForbiddenError(
          statusCode: statusCode,
          message: message,
        );

      case 404:
        return NotFoundError(
          statusCode: statusCode,
          message: message,
        );

      case 405:
        return MethodNotAllowedError(
          statusCode: statusCode,
          message: message,
        );

      case 409:
        return ConflictError(
          statusCode: statusCode,
          message: message,
        );

      case 422:
        return UnprocessableEntityError(
          statusCode: statusCode,
          message: message,
          error: error,
        );

      case 429:
        return TooManyRequestsError(
          statusCode: statusCode,
          message: message,
        );

      case 499:
        return AppRestrictionError(
          statusCode: statusCode,
          message: message,
          error: error,
        );

      case 500:
        return ServerError(
          statusCode: statusCode,
          message: message,
        );

      case 502:
        return BadGatewayError(
          statusCode: statusCode,
          message: message,
        );

      case 503:
        return ServiceUnavailableError(
          statusCode: statusCode,
          message: message,
        );

      case 504:
        return GatewayTimeoutError(
          statusCode: statusCode,
          message: message,
        );

      case 505:
        return HttpVersionNotSupportedError(
          statusCode: statusCode,
          message: message,
        );

      default:
        return AppException(
          statusCode,
          message,
          error: error,
        );
    }
  }

  static AppException _handleUnknownError(
    DioException exception,
  ) {
    final error = exception.error;

    if (error is SocketException) {
      return const NoInternetError();
    }

    if (error is HandshakeException) {
      return const HandshakeError();
    }

    return const UnknownError();
  }

  static String _extractMessage(Response<dynamic> response) {
    final data = response.data;

    if (data is Map) {
      final map = Map<String, dynamic>.from(data);

      return map['message']?.toString() ??
          response.statusMessage ??
          'Something went wrong';
    }

    return response.statusMessage ?? 'Something went wrong';
  }

  static ErrorModel? _extractError(
    Response<dynamic> response,
  ) {
    final data = response.data;

    if (data is! Map) {
      return null;
    }

    final map = Map<String, dynamic>.from(data);
    final error = map['error'];

    if (error is! Map) {
      return null;
    }

    try {
      return ErrorModel.fromJson(
        Map<String, dynamic>.from(error),
      );
    } catch (_) {
      return null;
    }
  }

  static bool _isTokenExpired(
    Response<dynamic> response,
  ) {
    final data = response.data;

    if (data is! Map) {
      return false;
    }

    final map = Map<String, dynamic>.from(data);

    final message =
        map['message']?.toString().toLowerCase() ?? '';

    final code = map['code']?.toString();

    return code == 'TOKEN_EXPIRED' ||
        message.contains('expired');
  }
}