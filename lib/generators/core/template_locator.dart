import 'dart:io';

import 'package_locator.dart';

class TemplateLocator {
  const TemplateLocator();

  Future<File> resolve(String template) async {
    final root = const PackageLocator().packageRoot();

    final file = File('${root.path}/templates/$template');

    if (!file.existsSync()) throw Exception('Template not found: ${file.path}');

    return file;
  }
}
