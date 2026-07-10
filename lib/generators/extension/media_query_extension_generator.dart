import 'dart:io';

import '../../services/logger_service.dart';

/// Generates MediaQuery extension files for FKIT projects.
class MediaQueryExtensionGenerator {
  /// Generates the configured MediaQuery extension files for the current project.
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
      '${directory.path}/context_media_query_extension.dart',
    );

    await file.writeAsString(
      '''
import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  EdgeInsets get padding => mediaQuery.padding;

  bool get isKeyboardOpen => viewInsets.bottom > 0;

  Orientation get orientation => mediaQuery.orientation;

  bool get isPortrait => orientation == Orientation.portrait;

  bool get isLandscape => orientation == Orientation.landscape;
}
''',
    );

    LoggerService.success(
      'Generated media_query_extension.dart',
    );
  }
}
