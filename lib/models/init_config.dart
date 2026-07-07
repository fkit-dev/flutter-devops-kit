import 'flavor_details.dart';

class InitConfig {
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

  factory InitConfig.fromMap(
    Map<dynamic, dynamic> map,
  ) {
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
      projectName: map['project_name'] ?? '',
      useFvm: tooling['use_fvm'] ?? false,
      android: platforms['android'] ?? true,
      ios: platforms['ios'] ?? true,
      web: platforms['web'] ?? false,
      flavoringEnabled: flavoring['enabled'] ?? false,
      defaultFlavor: flavorsMap['default'] ?? 'main',
      flavors: flavors,
      localizationEnabled: localization['enabled'] ?? false,
      arbDir: localization['arb_dir'] ?? 'lib/l10n',
      outputDir: localization['output_dir'] ?? 'lib/gen/l10n',
      outputFile: localization['output_file'] ?? 'app_localizations.dart',
      defaultLocale: localization['default_locale'] ?? 'en',
      locales: (localization['locales'] as List?)?.map((e) => e.toString()).toList() ?? ['en'],
      debugInfo: build['debug_info'] ?? './debug-info',
      obfuscate: build['obfuscate'] ?? true,
      mainEntry: entry['main'] ?? 'lib/main.dart',
      testerGroup: firebase['tester_group'] ?? 'internal-testers',
      featureDir: map['featureDir'] ?? 'lib/features',
      defaultTemplate: generator['default_template'] ?? 'riverpod_clean',
    );
  }
}
