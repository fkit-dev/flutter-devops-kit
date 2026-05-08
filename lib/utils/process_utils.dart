import 'dart:io';

class ProcessUtils {
  static Future<bool> commandExists(String command) async {
    try {
      final result = await Process.run('which', [command]);

      return result.exitCode == 0;
    } catch (_) {
      return false;
    }
  }
}
