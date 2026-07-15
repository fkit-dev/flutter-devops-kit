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
  factory LocalizationConfig.fromMap(Map<dynamic, dynamic> map) {
    return LocalizationConfig(
      enabled: map['enabled'] ?? false,
      arbDir: map['arb_dir']?.toString() ?? 'lib/l10n',
      templateArb: map['template']?.toString() ?? 'app_en.arb',
      outputDir: map['output_dir']?.toString() ?? 'lib/gen/l10n',
      outputFile: map['output_file']?.toString() ?? 'app_localizations.dart',
      defaultLocale: map['default_locale']?.toString() ?? 'en',
      locales: (map['locales'] as List?)
              ?.map((locale) => locale.toString())
              .where((locale) => locale.isNotEmpty)
              .toList() ??
          const ['en'],
    );
  }
}
