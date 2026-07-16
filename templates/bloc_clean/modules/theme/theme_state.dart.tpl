import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
sealed class AppThemeState with _$AppThemeState {
  const factory AppThemeState({
{{#if has_dark_theme}}
@Default(ThemeMode.system)
{{/if}}

{{#if no_dark_theme}}
@Default(ThemeMode.light)
{{/if}}

  ThemeMode themeMode,
  }) = _AppThemeState;
}