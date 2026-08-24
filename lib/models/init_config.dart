import 'environment/environment_config.dart';
import 'firebase/firebase_config.dart';
import 'localization/localization_config.dart';

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

  /// The application flavors configured for the project.
  ///
  /// Projects without flavoring use `main` as the default target.
  final List<String> flavors;

  /// Environment configuration used by the project.
  final EnvironmentConfig environment;

  /// Firebase configuration used by the project.
  final FirebaseConfig firebase;

  /// Localization configuration used by the project.
  final LocalizationConfig localization;

  /// The directory where debug information is generated.
  final String debugInfo;

  /// Whether release builds use code obfuscation.
  final bool obfuscate;

  /// The main Dart entry-point file used by the project.
  final String mainEntry;

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
    required this.environment,
    required this.firebase,
    required this.localization,
    required this.debugInfo,
    required this.obfuscate,
    required this.mainEntry,
    required this.featureDir,
    required this.defaultTemplate,
  });

  /// Creates an FKIT project configuration from the provided [map].
  ///
  /// Uses default configuration values for settings that are not specified.
  factory InitConfig.fromMap(Map<dynamic, dynamic> map) {
    final fkit = Map<dynamic, dynamic>.from(map['fkit'] ?? const {});
    final tooling = Map<dynamic, dynamic>.from(map['tooling'] ?? const {});
    final platforms = Map<dynamic, dynamic>.from(map['platforms'] ?? const {});
    final build = Map<dynamic, dynamic>.from(map['build'] ?? const {});
    final entry = Map<dynamic, dynamic>.from(map['entry'] ?? const {});
    final flavoring = Map<dynamic, dynamic>.from(map['flavoring'] ?? const {});
    final environment =
        Map<dynamic, dynamic>.from(map['environment'] ?? const {});
    final firebase = Map<dynamic, dynamic>.from(map['firebase'] ?? const {});
    final localization =
        Map<dynamic, dynamic>.from(map['localization'] ?? const {});
    final generator = Map<dynamic, dynamic>.from(map['generator'] ?? const {});
    final flavors = (map['flavors'] as List?)
            ?.map((flavor) => flavor.toString())
            .where((flavor) => flavor.isNotEmpty)
            .toList() ??
        const <String>[];
    final defaultFlavor = flavoring['default']?.toString() ??
        (flavors.isNotEmpty ? flavors.first : 'main');

    return InitConfig(
      version: fkit['version']?.toString() ?? '0.1.1',
      projectName: map['project_name']?.toString() ?? '',
      useFvm: tooling['use_fvm'] ?? false,
      android: platforms['android'] ?? true,
      ios: platforms['ios'] ?? true,
      web: platforms['web'] ?? false,
      flavoringEnabled: flavoring['enabled'] ?? false,
      defaultFlavor: defaultFlavor,
      flavors: flavors.isEmpty ? const ['main'] : flavors,
      environment: EnvironmentConfig.fromMap(environment),
      firebase: FirebaseConfig.fromMap(firebase),
      localization: LocalizationConfig.fromMap(localization),
      debugInfo: build['debug_info']?.toString() ?? './debug-info',
      obfuscate: build['obfuscate'] ?? true,
      mainEntry: entry['main']?.toString() ?? 'lib/main.dart',
      featureDir: generator['feature_dir']?.toString() ?? 'lib/features',
      defaultTemplate:
          generator['default_template']?.toString() ?? 'bloc_clean',
    );
  }
}
