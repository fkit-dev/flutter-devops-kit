import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'failure/app_exception.dart';
import 'response/base_response.dart';
import 'response/pagination.dart';
import 'response/response_mapper.dart';

BaseResponse<dynamic> _parseInBackground(
  Map<String, dynamic> json,
) {
  final status = json['status'] as bool? ?? false;
  final message = json['message']?.toString() ?? '';

  final rawPagination = json['pagination'];

  Pagination? pagination;

  if (rawPagination is Map) {
    pagination = Pagination.fromJson(
      Map<String, dynamic>.from(rawPagination),
    );
  }

  return BaseResponse<dynamic>(
    status: status,
    message: message,
    data: json['data'],
    pagination: pagination,
  );
}

class Parser {
  const Parser._();

  static const int _isolateThreshold = 10000;

  static Future<Either<AppException, BaseResponse<T>>>
      parseBaseResponse<T>(
    Response<dynamic> response,
    ResponseMapper<T> mapper,
  ) async {
    try {
      final responseData = response.data;

      if (responseData is String) {
        return Left(DataTransmissionError());
      }

      if (responseData is! Map) {
        return Left(ParsingError());
      }

      final json = Map<String, dynamic>.from(responseData);

      final BaseResponse<dynamic> base;

      if (_shouldUseIsolate(json)) {
        base = await compute(
          _parseInBackground,
          json,
        );
      } else {
        base = _parseInBackground(json);
      }

      if (!base.status) {
        return Left(
          ValidationError(
            message: base.message,
          ),
        );
      }

      final data = base.data;

      final T? parsedData = data == null
          ? null
          : mapper.fromJson(data);

      return Right(
        BaseResponse<T>(
          status: base.status,
          message: base.message,
          data: parsedData,
          pagination: base.pagination,
        ),
      );
    } on AppException catch (exception) {
      return Left(exception);
    } catch (_) {
      return Left(ParsingError());
    }
  }

  static bool _shouldUseIsolate(
    Map<String, dynamic> json,
  ) {
    try {
      return jsonEncode(json).length > _isolateThreshold;
    } catch (_) {
      return false;
    }
  }
}