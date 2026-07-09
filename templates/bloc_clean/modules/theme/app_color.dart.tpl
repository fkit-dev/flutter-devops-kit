import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);

  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color lightSurface = Color(0xFFF8FAFC);
  static const Color darkSurface = Color(0xFF111827);

  static const Color lightCard = Colors.white;
  static const Color darkCard = Color(0xFF1F2937);

  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFD1D5DB);

  static const LinearGradient primaryGradient = LinearGradient(colors: [primary,primaryLight],);
}