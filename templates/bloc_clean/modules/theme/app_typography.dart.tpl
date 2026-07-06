import 'package:flutter/material.dart';

class AppTypography {
  const AppTypography._();

  static const String? fontFamily = null;

  static TextTheme create(
    ColorScheme colorScheme,
  ) {
    return TextTheme(
      displayLarge: _style(
        32,
        colorScheme.onSurface,
        FontWeight.w700,
      ),

      displayMedium: _style(
        28,
        colorScheme.onSurface,
        FontWeight.w700,
      ),

      displaySmall: _style(
        24,
        colorScheme.onSurface,
        FontWeight.w700,
      ),

      headlineLarge: _style(
        24,
        colorScheme.onSurface,
        FontWeight.w600,
      ),

      headlineMedium: _style(
        22,
        colorScheme.onSurface,
        FontWeight.w600,
      ),

      headlineSmall: _style(
        20,
        colorScheme.onSurface,
        FontWeight.w600,
      ),

      titleLarge: _style(
        18,
        colorScheme.onSurface,
        FontWeight.w600,
      ),

      titleMedium: _style(
        16,
        colorScheme.onSurface,
        FontWeight.w500,
      ),

      titleSmall: _style(
        14,
        colorScheme.onSurface,
        FontWeight.w500,
      ),

      bodyLarge: _style(
        16,
        colorScheme.onSurface,
      ),

      bodyMedium: _style(
        14,
        colorScheme.onSurface,
      ),

      bodySmall: _style(
        12,
        colorScheme.onSurfaceVariant,
      ),

      labelLarge: _style(
        14,
        colorScheme.onSurface,
        FontWeight.w500,
      ),

      labelMedium: _style(
        12,
        colorScheme.onSurfaceVariant,
        FontWeight.w500,
      ),

      labelSmall: _style(
        11,
        colorScheme.onSurfaceVariant,
        FontWeight.w500,
      ),
    );
  }

  static TextStyle _style(
    double size,
    Color color, [
    FontWeight weight = FontWeight.w400,
  ]) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}