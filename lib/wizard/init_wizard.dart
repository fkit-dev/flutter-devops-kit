import '../models/init_config.dart';
import '../services/logger_service.dart';
import 'steps/feature_step.dart';
import 'steps/firebase_step.dart';
import 'steps/flavor_step.dart';
import 'steps/generator_step.dart';
import 'steps/localization_step.dart';
import 'steps/platform_step.dart';
import 'steps/project_step.dart';
import 'steps/tooling_step.dart';

class InitWizard {
  Future<InitConfig> start() async {
    LoggerService.section(
      'FKIT Project Initialization',
    );

    final projectName = ProjectStep().collect();
    final featureDir = FeatureStep().collect();
    final useFvm = ToolingStep().collect();
    final platforms = PlatformStep().collect();
    final flavors = FlavorStep(platforms).collect();
    final testerGroup = FirebaseStep().collect();
    final localization = LocalizationStep().collect();
    final generator = GeneratorStep().collect();

    return InitConfig(
      projectName: projectName,
      useFvm: useFvm,
      android: platforms.android,
      ios: platforms.ios,
      web: platforms.web,
      flavoringEnabled: flavors.enabled,
      defaultFlavor: flavors.defaultFlavor,
      flavors: flavors.flavors,
      localizationEnabled: localization.enabled,
      arbDir: localization.arbDir,
      outputDir: localization.outputDir,
      outputFile: localization.outputFile,
      defaultLocale: localization.defaultLocale,
      locales: localization.locales,
      debugInfo: './debug-info',
      obfuscate: true,
      mainEntry: 'lib/main.dart',
      featureDir: featureDir,
      testerGroup: testerGroup,
      defaultTemplate: generator.defaultTemplate,
    );
  }
}
