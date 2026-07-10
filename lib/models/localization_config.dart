/// Defines localization configuration for an FKIT project.
class LocalizationConfig {
  /// Whether localization support is enabled.
  final bool enabled;

  /// The directory containing the project's ARB files.
  final String arbDir;

  /// The ARB file used as the localization template.
  final String templateArb;

  /// The directory where generated localization files are written.
  final String outputDir;

  /// The name of the generated localization output file.
  final String outputFile;

  /// The default locale used by the project.
  final String defaultLocale;

  /// The locales supported by the project.
  final List<String> locales;

  /// Creates a localization configuration.
  const LocalizationConfig({
    required this.enabled,
    required this.arbDir,
    required this.templateArb,
    required this.outputDir,
    required this.outputFile,
    required this.defaultLocale,
    required this.locales,
  });

  /// Creates a localization configuration from the provided [map].
  ///
  /// Uses default localization settings for values that are not specified.
  factory LocalizationConfig.fromMap(Map map) {
    final localization = map['localization'] as Map? ?? {};

    return LocalizationConfig(
      enabled: localization['enabled'] ?? false,
      arbDir: localization['arb_dir'] ?? 'lib/l10n',
      templateArb: localization['template'] ?? 'app_en.arb',
      outputDir: localization['output_dir'] ?? 'lib/gen/l10n',
      outputFile: localization['output_file'] ?? 'app_localizations.dart',
      defaultLocale: localization['default_locale'] ?? 'en',
      locales: List<String>.from(localization['locales'] ?? ['en']),
    );
  }
}
