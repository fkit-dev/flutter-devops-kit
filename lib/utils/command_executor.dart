import 'dart:convert';
import 'dart:io';

import '../services/logger_service.dart';

class CommandExecutor {
  static Future<void> run(String command, List<String> arguments) async {
    final fullCommand = '$command ${arguments.join(' ')}';

    LoggerService.command(fullCommand);

    LoggerService.progress('Executing command...');

    final process = await Process.start(command, arguments, runInShell: true);

    process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
      LoggerService.progressComplete();

      print(line);

      LoggerService.progress('Executing command...');
    });

    process.stderr
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
      LoggerService.progressFail();

      print(line);

      LoggerService.progress('Executing command...');
    });

    final exitCode = await process.exitCode;

    LoggerService.progressComplete();

    if (exitCode != 0) {
      LoggerService.error('Command failed');

      throw Exception('Command failed: $fullCommand');
    }

    LoggerService.success('Command completed');
  }
}
