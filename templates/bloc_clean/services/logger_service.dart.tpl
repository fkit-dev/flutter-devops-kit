import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';

class LoggerService {
  LoggerService._();

  static final Talker talker = Talker(
    settings: TalkerSettings(
      enabled: kDebugMode,
      useConsoleLogs: true,
    ),
  );

  static String _caller() {
    final trace = StackTrace.current.toString().split('\n');

    final regex = RegExp(
      r'package:.+?/([^ ]+) (\d+):(\d+)',
    );

    for (final line in trace) {
      if (line.contains('logger_service.dart')) {
        continue;
      }

      final match = regex.firstMatch(line);

      if (match != null) {
        final file = match.group(1)?.split('/').last;
        final lineNumber = match.group(2);
        final columnNumber = match.group(3);

        return '$file:$lineNumber:$columnNumber';
      }
    }

    return 'unknown';
  }
}

void logInfo(String message) {
  if (!kDebugMode) return;

  LoggerService.talker.info(
    '[${LoggerService._caller()}]\n$message',
  );
}

void logWarning(String message) {
  if (!kDebugMode) return;

  LoggerService.talker.warning(
    '[${LoggerService._caller()}]\n$message',
  );
}

void logDebug(String message) {
  if (!kDebugMode) return;

  LoggerService.talker.debug(
    '[${LoggerService._caller()}]\n$message',
  );
}

void logError(
  String message, {
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!kDebugMode) return;

  LoggerService.talker.error(
    '[${LoggerService._caller()}]\n$message',
    error,
    stackTrace,
  );
}