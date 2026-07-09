import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failure/app_exception.dart';
import 'failure/failure.dart';
import 'parser.dart';
import 'response/base_response.dart';
import 'response/response_mapper.dart';
import 'base_api_service.dart';

class NetworkApiService implements BaseApiService {
  NetworkApiService(this._dio);

  final Dio _dio;

  Future<Either<AppException, BaseResponse<T>>> _request<T>(
    Future<Response<dynamic>> Function() requestCall,
    ResponseMapper<T> mapper,
  ) async {
    try {
      final response = await requestCall();

      return Parser.parseBaseResponse<T>(
        response,
        mapper,
      );
    } on DioException catch (exception) {
      return Left(
        Failure.handleDioError(exception),
      );
    } on AppException catch (exception) {
      return Left(exception);
    } catch (_) {
      return Left(ParsingError());
    }
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> getApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.get<dynamic>(
        endpoint,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> postApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.post<dynamic>(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> putApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.put<dynamic>(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> patchApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.patch<dynamic>(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> deleteApi<T>(
    String endpoint,
    ResponseMapper<T> mapper, {
    dynamic body,
    Options? options,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      () => _dio.delete<dynamic>(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }
}