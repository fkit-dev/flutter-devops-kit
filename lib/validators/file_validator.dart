import 'dart:io';

class FileValidator {
  static bool exists(String path) {
    return File(path).existsSync();
  }
}
