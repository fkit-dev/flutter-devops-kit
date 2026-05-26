import 'flavor_config.dart';
import 'platform_config.dart';

class ProjectConfig {
  final bool useFvm;

  final String debugInfo;

  final bool obfuscate;

  final String mainEntry;

  final String defaultFlavor;

  final String testerGroup;

  final PlatformConfig platforms;

  final Map<String, FlavorConfig> flavors;

  ProjectConfig({
    required this.useFvm,
    required this.debugInfo,
    required this.obfuscate,
    required this.mainEntry,
    required this.defaultFlavor,
    required this.testerGroup,
    required this.platforms,
    required this.flavors,
  });

  factory ProjectConfig.fromMap(Map<dynamic, dynamic> map) {
    final tooling = map['tooling'] ?? {};

    final build = map['build'] ?? {};

    final entry = map['entry'] ?? {};

    final firebase = map['firebase'] ?? {};

    final flavorsMap = map['flavors'] ?? {};

    final flavors = <String, FlavorConfig>{};

    for (final item in flavorsMap.entries) {
      if (item.key == 'default') continue;

      flavors[item.key] = FlavorConfig.fromMap(item.value);
    }

    return ProjectConfig(
      useFvm: tooling['use_fvm'] ?? false,

      debugInfo: build['debug_info'] ?? './debug-info',

      obfuscate: build['obfuscate'] ?? true,

      mainEntry: entry['main'] ?? 'lib/main.dart',

      defaultFlavor: flavorsMap['default'] ?? 'development',

      testerGroup: firebase['tester_group'] ?? '',

      platforms: PlatformConfig.fromMap(map['platforms'] ?? {}),

      flavors: flavors,
    );
  }
}
