import 'package:mason_logger/mason_logger.dart';

class LoggerService {
  static final Logger _logger = Logger();

  static Progress? _progress;

  static void section(String message) {
    print('');

    _logger.info(lightBlue.wrap('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'));

    _logger.info(lightBlue.wrap('┃ 📦  $message'));

    _logger.info(lightBlue.wrap('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'));

    print('');
  }

  static void success(String message) {
    _logger.success(message);
  }

  static void error(String message) {
    _logger.err(message);
  }

  static void warning(String message) {
    _logger.warn(message);
  }

  static void info(String message) {
    _logger.info(cyan.wrap(message));
  }

  static void command(String message) {
    _logger.info(yellow.wrap('🚀 $message'));
  }

  static void divider() {
    _logger.info(darkGray.wrap('────────────────────────────────────'));
  }

  static void blank() {
    print('');
  }

  static void progress(String message) {
    _progress?.complete();

    _progress = _logger.progress(magenta.wrap(message) ?? message);
  }

  static void progressComplete([String? message]) {
    _progress?.complete(message ?? 'Completed');

    _progress = null;
  }

  static void progressFail([String? message]) {
    _progress?.fail(message ?? 'Failed');

    _progress = null;
  }

  static void headline(String message) {
    print('');

    _logger.info(green.wrap('━━━ $message ━━━'));

    print('');
  }
}
