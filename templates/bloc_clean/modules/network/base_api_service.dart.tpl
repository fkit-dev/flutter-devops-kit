import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure/app_exception.dart';
import 'response/base_response.dart';
import 'response/response_mapper.dart';

abstract class BaseApiService {
  Future<Either<AppException, BaseResponse<T>>> getApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, BaseResponse<T>>> postApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, BaseResponse<T>>> putApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, BaseResponse<T>>> patchApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<Either<AppException, BaseResponse<T>>> deleteApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });
}