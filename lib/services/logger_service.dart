import 'package:mason_logger/mason_logger.dart';

/// Provides formatted console logging utilities used throughout FKIT.
///
/// Supports informational messages, warnings, errors, progress indicators,
/// command output, and formatted console sections.
class LoggerService {
  const LoggerService._();

  static final Logger _logger = Logger();

  static Progress? _progress;

  /// Prints a formatted section header containing the specified [message].
  static void section(String message) {
    print('');

    _logger.info(lightBlue.wrap('┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'));

    _logger.info(lightBlue.wrap('┃ 📦  $message'));

    _logger.info(lightBlue.wrap('┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'));

    print('');
  }

  /// Prints a success message.
  static void success(String message) {
    _logger.success(message);
  }

  /// Prints an error message.
  static void error(String message) {
    _logger.err(message);
  }

  /// Prints a warning message.
  static void warning(String message) {
    _logger.warn(message);
  }

  /// Prints an informational message.
  static void info(String message) {
    _logger.info(cyan.wrap(message));
  }

  /// Prints a formatted command execution message.
  static void command(String message) {
    _logger.info(yellow.wrap('🚀 $message'));
  }

  /// Prints a horizontal divider.
  static void divider() {
    _logger.info(darkGray.wrap('────────────────────────────────────'));
  }

  /// Prints an empty line to the console.
  static void blank() {
    print('');
  }

  /// Starts a progress indicator with the specified [message].
  ///
  /// Any currently active progress indicator is completed before the new one
  /// is started.
  static void progress(String message) {
    _progress?.complete();

    _progress = _logger.progress(magenta.wrap(message) ?? message);
  }

  /// Completes the active progress indicator.
  ///
  /// Uses [message] as the completion message when provided.
  static void progressComplete([String? message]) {
    _progress?.complete(message ?? 'Completed');

    _progress = null;
  }

  /// Marks the active progress indicator as failed.
  ///
  /// Uses [message] as the failure message when provided.
  static void progressFail([String? message]) {
    _progress?.fail(message ?? 'Failed');

    _progress = null;
  }

  /// Prints a formatted headline containing the specified [message].
  static void headline(String message) {
    print('');

    _logger.info(green.wrap('━━━ $message ━━━'));

    print('');
  }
}
