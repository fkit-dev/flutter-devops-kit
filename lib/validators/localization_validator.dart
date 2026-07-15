import 'dart:io';

import '../models/init_config.dart';
import '../services/logger_service.dart';

/// Validates localization configuration for an FKIT project.
class LocalizationValidator {
  const LocalizationValidator._();

  /// Validates the project's localization configuration.
  ///
  /// Throws an exception when the configuration is invalid or incomplete.
  static void validate(
    InitConfig config,
  ) {
    if (!config.localization.enabled) {
      LoggerService.warning('Localization is disabled in fkit.yaml.');
      return;
    }

    _validateArbDirectory(config);
    _validateTemplate(config);
    _validateLocales(config);
    _validateOutputDirectory(config);
    _validateDefaultLocale(config);
    LoggerService.success('Localization configuration validated.');
  }

  static void _validateArbDirectory(InitConfig config) {
    final directory = Directory(config.localization.arbDir);

    if (!directory.existsSync())
      throw Exception('ARB directory not found: ${config.localization.arbDir}');
    LoggerService.success('ARB directory found.');
  }

  static void _validateTemplate(InitConfig config) {
    final template = File(
        '${config.localization.arbDir}/app_${config.localization.defaultLocale}.arb');

    if (!template.existsSync()) {
      throw Exception('Template ARB not found: ${template.path}');
    }

    LoggerService.success('Template ARB found.');
  }

  static void _validateLocales(InitConfig config) {
    for (final locale in config.localization.locales) {
      final file = File('${config.localization.arbDir}/app_$locale.arb');

      if (!file.existsSync())
        throw Exception('Missing locale file: ${file.path}');
      LoggerService.success('Locale "$locale" found.');
    }
  }

  static void _validateOutputDirectory(InitConfig config) {
    final directory = Directory(config.localization.outputDir);

    if (!directory.existsSync()) {
      LoggerService.warning('Output directory does not exist yet. '
          'It will be created after flutter gen-l10n.');
    } else {
      LoggerService.success('Output directory found.');
    }
  }

  static void _validateDefaultLocale(InitConfig config) {
    if (!config.localization.locales
        .contains(config.localization.defaultLocale)) {
      throw Exception('Default locale "${config.localization.defaultLocale}" '
          'is not included in supported locales.');
    }

    LoggerService.success('Default locale validated.');
  }
}
