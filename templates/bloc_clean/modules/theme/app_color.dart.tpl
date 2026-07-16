import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  /// Brand colors
  static const Color primary = Color({{primary_color}});

{{#if secondary_is_custom}}
  static const Color secondary = Color({{secondary_color}});
{{/if}}

{{#if secondary_is_generated}}
  static const Color secondary = primary;
{{/if}}

  /// Semantic colors
  static const Color success = Color({{success_color}});
  static const Color warning = Color({{warning_color}});
  static const Color error = Color({{error_color}});

  /// Common colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  /// Neutral colors
  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFD1D5DB);

{{#if has_gradient}}
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primary,
      secondary,
    ],
  );
{{/if}}
}