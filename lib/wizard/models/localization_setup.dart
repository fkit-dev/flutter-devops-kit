/// Defines the localization configuration for an FKIT project.
///
/// Contains settings for ARB files, generated localization output, and the
/// locales supported by the project.
class LocalizationSetup {
  /// Whether localization support is enabled.
  final bool enabled;

  /// The directory containing the project's ARB files.
  final String arbDir;

  /// The directory where generated localization files are written.
  final String outputDir;

  /// The name of the generated localization output file.
  final String outputFile;

  /// The default locale used by the project.
  final String defaultLocale;

  /// The locales supported by the project.
  final List<String> locales;

  /// Creates a localization configuration.
  const LocalizationSetup({
    required this.enabled,
    required this.arbDir,
    required this.outputDir,
    required this.outputFile,
    required this.defaultLocale,
    required this.locales,
  });
}
