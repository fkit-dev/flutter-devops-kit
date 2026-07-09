import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../../services/logger/logger_service.dart';

class ApiResponseLogInterceptor {
  const ApiResponseLogInterceptor._();

  static Interceptor create() {
    return TalkerDioLogger(
      talker: LoggerService.talker,
      settings: TalkerDioLoggerSettings(
        enabled: kDebugMode,
        printRequestData: kDebugMode,
        printRequestHeaders: kDebugMode,
        printErrorHeaders: kDebugMode,
        printErrorData: kDebugMode,
        printResponseData: kDebugMode,
        printResponseTime: kDebugMode,
        printResponseMessage: kDebugMode,
      ),
    );
  }
}