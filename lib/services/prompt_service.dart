import 'dart:io';

class PromptService {
  static String ask(String question) {
    stdout.write('$question: ');

    return stdin.readLineSync()?.trim() ?? '';
  }

  static bool confirm(String question) {
    stdout.write('$question (y/n): ');

    final input = stdin.readLineSync()?.trim().toLowerCase();

    return input == 'y' || input == 'yes';
  }
}
