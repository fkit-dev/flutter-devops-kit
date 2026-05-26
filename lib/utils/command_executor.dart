import 'dart:async';
import 'dart:io';

import '../services/logger_service.dart';

class CommandExecutor {
  static Future<void> run(String command, List<String> arguments, {bool streamOutput = true}) async {
    try {
      final process = await Process.start(command, arguments, runInShell: true);

      if (streamOutput) {
        stdout.addStream(process.stdout);
        stderr.addStream(process.stderr);
      }

      final exitCode = await process.exitCode;

      if (exitCode != 0) {
        throw Exception('❌ Command failed with exit code $exitCode');
      }
    } catch (e) {
      LoggerService.error("Error: ${e.toString()}");
      rethrow;
    }
  }
}
