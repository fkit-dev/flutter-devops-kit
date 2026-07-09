import 'flavor_details.dart';

class InitConfig {
  final String version;
  final String projectName;
  final bool useFvm;
  final bool android;
  final bool ios;
  final bool web;
  final bool flavoringEnabled;
  final String defaultFlavor;
  final Map<String, FlavorDetails> flavors;
  final bool localizationEnabled;
  final String arbDir;
  final String outputDir;
  final String outputFile;
  final String defaultLocale;
  final List<String> locales;
  final String debugInfo;
  final bool obfuscate;
  final String mainEntry;
  final String testerGroup;
  final String featureDir;
  final String defaultTemplate;

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

      flavors[entry.key] =
          FlavorDetails.fromMap(Map<String, dynamic>.from(entry.value));
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
      outputFile:
          localization['output_file']?.toString() ?? 'app_localizations.dart',
      defaultLocale: localization['default_locale']?.toString() ?? 'en',
      locales: (localization['locales'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          ['en'],
      debugInfo: build['debug_info']?.toString() ?? './debug-info',
      obfuscate: build['obfuscate'] ?? true,
      mainEntry: entry['main']?.toString() ?? 'lib/main.dart',
      testerGroup: firebase['tester_group']?.toString() ?? 'internal-testers',
      featureDir: generator['feature_dir']?.toString() ?? 'lib/features',
      defaultTemplate:
          generator['default_template']?.toString() ?? 'riverpod_clean',
    );
  }
}
