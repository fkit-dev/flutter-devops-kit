import '../core/fkit_version.dart';
import '../models/init_config.dart';
import '../services/logger_service.dart';
import 'steps/environment_step.dart';
import 'steps/feature_step.dart';
import 'steps/firebase_step.dart';
import 'steps/flavor_step.dart';
import 'steps/generator_step.dart';
import 'steps/localization_step.dart';
import 'steps/platform_step.dart';
import 'steps/project_step.dart';
import 'steps/tooling_step.dart';

/// Guides the user through interactive FKIT project configuration.
class InitWizard {
  /// Starts the initialization wizard and collects project configuration.
  ///
  /// Returns the resulting [InitConfig] based on the user's selections.
  Future<InitConfig> start() async {
    LoggerService.section('FKIT Project Initialization');

    final projectName = ProjectStep().collect();
    final featureDir = FeatureStep().collect();
    final useFvm = ToolingStep().collect();
    final platforms = PlatformStep().collect();
    final flavors = FlavorStep().collect();
    final environment = EnvironmentStep(flavors: flavors).collect();
    final firebase =
        FirebaseStep(platforms: platforms, flavors: flavors).collect();
    final localization = LocalizationStep().collect();
    final generator = GeneratorStep().collect();

    return InitConfig(
      version: FkitVersion.current,
      projectName: projectName,
      useFvm: useFvm,
      android: platforms.android,
      ios: platforms.ios,
      web: platforms.web,
      flavoringEnabled: flavors.enabled,
      defaultFlavor: flavors.defaultFlavor,
      flavors: flavors.flavors,
      environment: environment,
      firebase: firebase,
      localization: localization,
      debugInfo: './debug-info',
      obfuscate: true,
      mainEntry: 'lib/main.dart',
      featureDir: featureDir,
      defaultTemplate: generator.defaultTemplate,
    );
  }
}
