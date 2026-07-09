import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
sealed class AppThemeState with _$AppThemeState {
  const factory AppThemeState({
    @Default(ThemeMode.system)
    ThemeMode themeMode,
  }) = _AppThemeState;
}