import 'flavor_details.dart';

/// Defines the complete configuration of an FKIT project.
class InitConfig {
  /// The FKIT configuration schema version.
  final String version;

  /// The name of the Flutter project.
  final String projectName;

  /// Whether Flutter Version Management (FVM) is enabled.
  final bool useFvm;

  /// Whether Android platform support is enabled.
  final bool android;

  /// Whether iOS platform support is enabled.
  final bool ios;

  /// Whether web platform support is enabled.
  final bool web;

  /// Whether application flavoring is enabled.
  final bool flavoringEnabled;

  /// The name of the default application flavor.
  final String defaultFlavor;

  /// The configured application flavors keyed by flavor name.
  final Map<String, FlavorDetails> flavors;

  /// Whether localization support is enabled.
  final bool localizationEnabled;

  /// The directory containing localization ARB files.
  final String arbDir;

  /// The directory where generated localization files are written.
  final String outputDir;

  /// The name of the generated localization output file.
  final String outputFile;

  /// The default locale used by the project.
  final String defaultLocale;

  /// The locales supported by the project.
  final List<String> locales;

  /// The directory where debug information is generated.
  final String debugInfo;

  /// Whether release builds use code obfuscation.
  final bool obfuscate;

  /// The main Dart entry-point file used by the project.
  final String mainEntry;

  /// The Firebase App Distribution tester group.
  final String testerGroup;

  /// The root directory where features are generated.
  final String featureDir;

  /// The default template used for code generation.
  final String defaultTemplate;

  /// Creates an FKIT project configuration.
  const InitConfig({
    required this.version,
    required this.projectName,
    required this.useFvm,
    required this.android,
    required this.ios,
    required this.web,
    required this.flavoringEnabled,
    required this.defaultFlavor,
    required this.flavors,
    required this.localizationEnabled,
    required this.arbDir,
    required this.outputDir,
    required this.outputFile,
    required this.defaultLocale,
    required this.locales,
    required this.debugInfo,
    required this.obfuscate,
    required this.mainEntry,
    required this.testerGroup,
    required this.featureDir,
    required this.defaultTemplate,
  });

  /// Creates an FKIT project configuration from the provided [map].
  ///
  /// Uses default configuration values for settings that are not specified.
  factory InitConfig.fromMap(Map<dynamic, dynamic> map) {
    final fkit = Map<String, dynamic>.from(map['fkit'] ?? {});
    final tooling = Map<String, dynamic>.from(map['tooling'] ?? {});
    final platforms = Map<String, dynamic>.from(map['platforms'] ?? {});
    final build = Map<String, dynamic>.from(map['build'] ?? {});
    final entry = Map<String, dynamic>.from(map['entry'] ?? {});
    final flavoring = Map<String, dynamic>.from(map['flavoring'] ?? {});
    final localization = Map<String, dynamic>.from(map['localization'] ?? {});
    final firebase = Map<String, dynamic>.from(map['firebase'] ?? {});
    final generator = Map<String, dynamic>.from(map['generator'] ?? {});
    final flavorsMap = Map<String, dynamic>.from(map['flavors'] ?? {});
    final flavors = <String, FlavorDetails>{};

    for (final entry in flavorsMap.entries) {
      if (entry.key == 'default') continue;

      flavors[entry.key] = FlavorDetails.fromMap(Map<String, dynamic>.from(entry.value));
    }

    return InitConfig(
      version: fkit['version']?.toString() ?? '0.1.1',
      projectName: map['project_name']?.toString() ?? '',
      useFvm: tooling['use_fvm'] ?? false,
      android: platforms['android'] ?? true,
      ios: platforms['ios'] ?? true,
      web: platforms['web'] ?? false,
      flavoringEnabled: flavoring['enabled'] ?? false,
      defaultFlavor: flavorsMap['default']?.toString() ?? 'main',
      flavors: flavors,
      localizationEnabled: localization['enabled'] ?? false,
      arbDir: localization['arb_dir']?.toString() ?? 'lib/l10n',
      outputDir: localization['output_dir']?.toString() ?? 'lib/gen/l10n',
      outputFile: localization['output_file']?.toString() ?? 'app_localizations.dart',
      defaultLocale: localization['default_locale']?.toString() ?? 'en',
      locales: (localization['locales'] as List?)?.map((e) => e.toString()).toList() ?? ['en'],
      debugInfo: build['debug_info']?.toString() ?? './debug-info',
      obfuscate: build['obfuscate'] ?? true,
      mainEntry: entry['main']?.toString() ?? 'lib/main.dart',
      testerGroup: firebase['tester_group']?.toString() ?? 'internal-testers',
      featureDir: generator['feature_dir']?.toString() ?? 'lib/features',
      defaultTemplate: generator['default_template']?.toString() ?? 'riverpod_clean',
    );
  }
}
