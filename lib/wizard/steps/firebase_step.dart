import '../../models/firebase/firebase_config.dart';
import '../../models/firebase/firebase_details.dart';
import '../../models/firebase/firebase_platform.dart';
import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/flavor_setup.dart';
import '../models/platform_setup.dart';
import '../wizard_step.dart';

/// Collects Firebase configuration during the initialization wizard.
class FirebaseStep extends WizardStep<FirebaseConfig> {
  /// The project platforms used to determine Firebase configuration.
  final PlatformSetup platforms;

  /// The flavor configuration used to determine Firebase targets.
  final FlavorSetup flavors;

  /// Creates a Firebase configuration step.
  FirebaseStep({
    required this.platforms,
    required this.flavors,
  });

  @override
  FirebaseConfig collect() {
    LoggerService.blank();
    LoggerService.info('Firebase');

    final enabled = PromptService.confirm(
      'Does project use Firebase?',
      defaultValue: false,
    );

    if (!enabled) {
      return const FirebaseConfig(
        enabled: false,
        testerGroup: 'internal-testers',
        configurations: {},
      );
    }

    final testerGroup = PromptService.ask(
      'Default Firebase tester group',
      defaultValue: 'internal-testers',
    );

    final configurations = <String, FirebaseDetails>{};

    for (final target in flavors.flavors) {
      LoggerService.blank();
      LoggerService.command(target);

      configurations[target] = FirebaseDetails(
        android: _collectPlatform(
          enabled: platforms.android,
          platform: 'Android',
          target: target,
        ),
        ios: _collectPlatform(
          enabled: platforms.ios,
          platform: 'iOS',
          target: target,
        ),
        web: _collectPlatform(
          enabled: platforms.web,
          platform: 'Web',
          target: target,
        ),
      );
    }

    return FirebaseConfig(
      enabled: true,
      testerGroup: testerGroup,
      configurations: configurations,
    );
  }

  FirebasePlatform? _collectPlatform({
    required bool enabled,
    required String platform,
    required String target,
  }) {
    if (!enabled) {
      return null;
    }

    return FirebasePlatform(
      appId: PromptService.ask(
        '$platform Firebase App ID',
      ),
      options: PromptService.ask(
        '$platform Firebase options',
        defaultValue: _defaultOptionsPath(target),
      ),
    );
  }

  String _defaultOptionsPath(String target) {
    if (!flavors.enabled) {
      return 'lib/firebase_options.dart';
    }

    return 'lib/firebase_options_$target.dart';
  }
}
