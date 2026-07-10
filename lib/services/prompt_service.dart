import 'dart:io';

/// Provides utilities for collecting user input from the command line.
class PromptService {
  /// Prompts the user with a [question] and returns the entered value.
  ///
  /// Returns [defaultValue] when the user provides no input and a default
  /// value is available.
  static String ask(
    String question, {
    String? defaultValue,
  }) {
    if (defaultValue != null && defaultValue.isNotEmpty) {
      stdout.write('$question [$defaultValue]: ');
    } else {
      stdout.write('$question: ');
    }

    final input = stdin.readLineSync()?.trim() ?? '';

    if (input.isEmpty && defaultValue != null) {
      return defaultValue;
    }

    return input;
  }

  /// Prompts the user to confirm a [question].
  ///
  /// Returns [defaultValue] when the user provides no input. Otherwise,
  /// returns `true` when the entered value is `y` or `yes`.
  static bool confirm(
    String question, {
    bool defaultValue = false,
  }) {
    final prompt = defaultValue ? '(Y/n)' : '(y/N)';

    stdout.write('$question $prompt: ');

    final input = stdin.readLineSync()?.trim().toLowerCase() ?? '';

    if (input.isEmpty) {
      return defaultValue;
    }

    return input == 'y' || input == 'yes';
  }
}
