import 'dart:io';

import '../services/logger_service.dart';

class CommandExecutor {
  static Future<void> run(String command, List<String> arguments) async {
    final fullCommand = '$command ${arguments.join(' ')}';

    LoggerService.command(fullCommand);

    LoggerService.progress('Executing command...');

    final process = await Process.start(command, arguments, runInShell: true);

    stdout.addStream(process.stdout);

    stderr.addStream(process.stderr);

    final exitCode = await process.exitCode;

    if (exitCode != 0) {
      LoggerService.progressFail('Command failed');

      throw Exception('Command failed: $fullCommand');
    }

    LoggerService.progressComplete('Command completed');
  }
}
