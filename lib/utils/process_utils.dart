import 'dart:io';

/// Provides utilities for working with system processes and commands.
class ProcessUtils {
  /// Returns whether the specified [command] is available on the system.
  static Future<bool> commandExists(String command) async {
    try {
      final result = await Process.run('which', [command]);

      return result.exitCode == 0;
    } catch (_) {
      return false;
    }
  }
}
