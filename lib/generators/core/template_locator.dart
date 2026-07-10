import 'dart:io';

import 'package_locator.dart';

/// Resolves template files bundled with the FKIT package.
class TemplateLocator {
  /// Creates a template locator.
  const TemplateLocator();

  /// Resolves the specified [template] to its corresponding file.
  ///
  /// Throws an [Exception] when the template file does not exist.
  Future<File> resolve(String template) async {
    final root = const PackageLocator().packageRoot();

    final file = File('${root.path}/templates/$template');

    if (!file.existsSync()) {
      throw Exception('Template not found: ${file.path}');
    }

    return file;
  }
}
