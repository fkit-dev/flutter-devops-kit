import 'dart:io';

import '../services/logger_service.dart';

class ThemeExtensionGenerator {
  static Future<void> generate() async {
    final directory = Directory(
      'lib/core/extensions',
    );

    if (!directory.existsSync()) {
      await directory.create(
        recursive: true,
      );
    }

    final file = File(
      '${directory.path}/context_theme_extension.dart',
    );

    await file.writeAsString(
      '''
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
''',
    );

    LoggerService.success(
      'Generated theme_extension.dart',
    );
  }
}
