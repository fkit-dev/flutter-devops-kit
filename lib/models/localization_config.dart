class LocalizationConfig {
  final bool enabled;
  final String arbDir;
  final String templateArb;
  final String outputDir;
  final String outputFile;
  final String defaultLocale;
  final List<String> locales;

  const LocalizationConfig({
    required this.enabled,
    required this.arbDir,
    required this.templateArb,
    required this.outputDir,
    required this.outputFile,
    required this.defaultLocale,
    required this.locales,
  });

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
