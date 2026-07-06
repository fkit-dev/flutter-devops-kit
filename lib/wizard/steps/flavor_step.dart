import '../../models/firebase_details.dart';
import '../../models/firebase_platform.dart';
import '../../models/flavor_details.dart';
import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/flavor_setup.dart';
import '../models/platform_setup.dart';
import '../wizard_step.dart';

class FlavorStep extends WizardStep<FlavorSetup> {
  final PlatformSetup platforms;

  FlavorStep(this.platforms);

  @override
  FlavorSetup collect() {
    LoggerService.blank();

    LoggerService.info('Flavors');

    final enabled = PromptService.confirm(
      'Does project use flavors?',
      defaultValue: false,
    );

    late final List<String> flavorNames;
    late final String defaultFlavor;

    if (enabled) {
      final flavorsInput = PromptService.ask(
        'Flavors (comma separated)',
        defaultValue: 'development,staging,production',
      );

      flavorNames = flavorsInput.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toSet().toList();

      defaultFlavor = PromptService.ask(
        'Default flavor',
        defaultValue: flavorNames.first,
      );
    } else {
      LoggerService.info(
        'Using default flavor: main',
      );

      flavorNames = ['main'];
      defaultFlavor = 'main';
    }

    final configs = <String, FlavorDetails>{};

    for (final flavor in flavorNames) {
      LoggerService.blank();

      LoggerService.command(flavor);

      final env = PromptService.ask('Env file path', defaultValue: enabled ? 'env/$flavor.json' : 'env/env.json');

      FirebasePlatform android = const FirebasePlatform(
        appId: '',
        options: '',
      );

      FirebasePlatform ios = const FirebasePlatform(
        appId: '',
        options: '',
      );

      FirebasePlatform web = const FirebasePlatform(
        appId: '',
        options: '',
      );

      if (platforms.android) {
        android = FirebasePlatform(
          appId: PromptService.ask(
            'Android Firebase App ID',
          ),
          options: PromptService.ask('Android Firebase options',
              defaultValue: enabled ? 'lib/firebase_options_$flavor.dart' : 'lib/firebase_options.dart'),
        );
      }

      if (platforms.ios) {
        ios = FirebasePlatform(
          appId: PromptService.ask(
            'iOS Firebase App ID',
          ),
          options: PromptService.ask('iOS Firebase options',
              defaultValue: enabled ? 'lib/firebase_options_$flavor.dart' : 'lib/firebase_options.dart'),
        );
      }

      if (platforms.web) {
        web = FirebasePlatform(
          appId: PromptService.ask(
            'Web Firebase App ID',
          ),
          options: PromptService.ask(
            'Web Firebase options',
            defaultValue: 'lib/firebase_options_$flavor.dart',
          ),
        );
      }

      configs[flavor] = FlavorDetails(
        env: env,
        firebase: FirebaseDetails(
          android: android,
          ios: ios,
          web: web,
        ),
      );
    }

    LoggerService.blank();

    return FlavorSetup(
      enabled: enabled,
      defaultFlavor: defaultFlavor,
      flavors: configs,
    );
  }
}
