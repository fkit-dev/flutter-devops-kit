class LocalizationSetup {
  final bool enabled;

  final String arbDir;

  final String outputDir;

  final String outputFile;

  final String defaultLocale;

  final List<String> locales;

  const LocalizationSetup({
    required this.enabled,
    required this.arbDir,
    required this.outputDir,
    required this.outputFile,
    required this.defaultLocale,
    required this.locales,
  });
}
