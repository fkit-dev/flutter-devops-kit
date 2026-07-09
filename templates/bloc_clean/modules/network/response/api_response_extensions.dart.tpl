import 'package:dartz/dartz.dart';

import '../failure/app_exception.dart';
import 'base_response.dart';
import 'paginated_result.dart';
import 'result.dart';
import 'result_message.dart';

extension ApiFutureEitherX<T>
    on Future<Either<AppException, BaseResponse<T>>> {
  Future<Either<AppException, R>> mapEntity<R>(
    R Function(T data) mapper,
  ) {
    return then(
      (either) => either.fold(
        Left.new,
        (response) {
          final data = response.data;

          if (data == null) {
            return Left(UnknownError());
          }

          return Right(mapper(data));
        },
      ),
    );
  }
}

extension ApiFutureEitherMessageX<T>
    on Future<Either<AppException, BaseResponse<T>>> {
  Future<Either<AppException, ResultMessage>> mapMessage() {
    return then(
      (either) => either.fold(
        Left.new,
        (response) => Right(
          ResultMessage(
            message: response.message,
          ),
        ),
      ),
    );
  }
}

extension ApiFutureEitherPaginatedX<T>
    on Future<
        Either<
          AppException,
          BaseResponse<PaginatedResult<T>>
        >> {
  Future<Either<AppException, PaginatedResult<R>>> mapPaginated<R>(
    R Function(T data) mapper,
  ) {
    return then(
      (either) => either.fold(
        Left.new,
        (response) {
          final data = response.data;

          if (data == null) {
            return Right(
              PaginatedResult<R>(
                items: const [],
                pagination: response.pagination,
                message: response.message,
              ),
            );
          }

          return Right(
            PaginatedResult<R>(
              items: data.items.map(mapper).toList(),
              pagination: response.pagination,
              message: response.message,
            ),
          );
        },
      ),
    );
  }
}

extension ApiFutureEitherResultX<T>
    on Future<Either<AppException, BaseResponse<T>>> {
  Future<Either<AppException, Result<R>>> mapResult<R>(
    R Function(T data) mapper,
  ) {
    return then(
      (either) => either.fold(
        Left.new,
        (response) {
          final data = response.data;

          if (data != null) {
            return Right(
              Result<R>(
                data: mapper(data),
                message: response.message,
              ),
            );
          }

          return Right(
            Result<R>(
              message: response.message.isEmpty
                  ? null
                  : response.message,
            ),
          );
        },
      ),
    );
  }
}