import 'dart:io';

class PromptService {
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
