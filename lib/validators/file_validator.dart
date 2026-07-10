import 'dart:io';

/// Provides utilities for validating files.
class FileValidator {
  /// Returns whether a file exists at the specified [path].
  static bool exists(String path) {
    return File(path).existsSync();
  }
}
