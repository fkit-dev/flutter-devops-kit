import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'theme_state.dart';
import 'theme_constants.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState());

  Future<void> loadTheme() async {
    final box = await Hive.openBox(ThemeConstants.settingsBox);

    final value = box.get(ThemeConstants.themeModeKey);

    emit(
      state.copyWith(
        themeMode: switch (value) {
                     'light' => ThemeMode.light,

                   {{#if has_dark_theme}}
                     'dark' => ThemeMode.dark,
                   {{/if}}
                   
                     _ => ThemeMode.system,
                   },
      ),
    );
  }

  Future<void> setTheme(
    ThemeMode mode,
  ) async {
    final box = await Hive.openBox(ThemeConstants.settingsBox);

    await box.put(
      ThemeConstants.themeModeKey,
      switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      },
    );

    emit(
      state.copyWith(
        themeMode: mode,
      ),
    );
  }
}