import 'error_model.dart';

class AppException implements Exception {
  const AppException(
    this.code,
    this.message, {
    this.error,
    this.buttonText,
  });

  final int code;
  final String message;
  final ErrorModel? error;
  final String? buttonText;

  @override
  String toString() {
    return 'AppException(code: $code, message: $message)';
  }
}

class NoInternetError extends AppException {
  const NoInternetError()
      : super(
          503,
          'No internet connection',
        );
}

class TimeoutError extends AppException {
  const TimeoutError()
      : super(
          504,
          'The request timed out',
        );
}

class HandshakeError extends AppException {
  const HandshakeError()
      : super(
          526,
          'SSL handshake failed',
        );
}

class SessionExpiry extends AppException {
  const SessionExpiry()
      : super(
          401,
          'Session has expired',
        );
}

class UnknownError extends AppException {
  const UnknownError()
      : super(
          520,
          'An unknown error occurred',
        );
}

class ParsingError extends AppException {
  const ParsingError()
      : super(
          520,
          'Error parsing response data',
        );
}

class ForbiddenError extends AppException {
  ForbiddenError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 403,
          message ?? 'Forbidden',
        );
}

class UnauthorizedError extends AppException {
  UnauthorizedError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 401,
          message ?? 'Unauthorized',
        );
}

class NotFoundError extends AppException {
  NotFoundError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 404,
          message ?? 'Resource not found',
        );
}

class BadRequestError extends AppException {
  BadRequestError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 400,
          message ?? 'Bad request',
        );
}

class MethodNotAllowedError extends AppException {
  MethodNotAllowedError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 405,
          message ?? 'Method not allowed',
        );
}

class ConflictError extends AppException {
  ConflictError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 409,
          message ?? 'Conflict',
        );
}

class UnprocessableEntityError extends AppException {
  UnprocessableEntityError({
    int? statusCode,
    String? message,
    ErrorModel? error,
  }) : super(
          statusCode ?? 422,
          message ?? 'Unprocessable entity',
          error: error,
        );
}

class TooManyRequestsError extends AppException {
  TooManyRequestsError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 429,
          message ?? 'Too many requests',
        );
}

class AppRestrictionError extends AppException {
  AppRestrictionError({
    int? statusCode,
    String? message,
    ErrorModel? error,
  }) : super(
          statusCode ?? 499,
          message ??
              'App restricted. Please try again after some time.',
          error: error,
        );
}

class ServerError extends AppException {
  ServerError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 500,
          message ?? 'Internal server error',
        );
}

class BadGatewayError extends AppException {
  BadGatewayError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 502,
          message ?? 'Bad gateway',
        );
}

class ServiceUnavailableError extends AppException {
  ServiceUnavailableError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 503,
          message ?? 'Service temporarily unavailable',
        );
}

class GatewayTimeoutError extends AppException {
  GatewayTimeoutError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 504,
          message ?? 'Gateway timeout',
        );
}

class HttpVersionNotSupportedError extends AppException {
  HttpVersionNotSupportedError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 505,
          message ?? 'HTTP version not supported',
        );
}

class ValidationError extends AppException {
  ValidationError({
    int? statusCode,
    String? message,
    ErrorModel? error,
  }) : super(
          statusCode ?? 0,
          message ?? 'Something went wrong',
          error: error,
        );
}

class DataTransmissionError extends AppException {
  DataTransmissionError({
    int? statusCode,
    String? message,
  }) : super(
          statusCode ?? 602,
          message ??
              'Unable to process your request at the moment. '
                  'Please try again.',
        );
}