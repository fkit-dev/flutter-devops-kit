import '../../models/environment/environment_config.dart';
import '../../models/environment/environment_details.dart';
import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/flavor_setup.dart';
import '../wizard_step.dart';

/// Collects environment configuration during the initialization wizard.
class EnvironmentStep extends WizardStep<EnvironmentConfig> {
  /// The flavor configuration used to determine environment targets.
  final FlavorSetup flavors;

  /// Creates an environment configuration step.
  EnvironmentStep(this.flavors);

  @override
  EnvironmentConfig collect() {
    LoggerService.blank();
    LoggerService.info('Environment');

    final enabled = PromptService.confirm(
      'Does project use environment files?',
      defaultValue: true,
    );

    if (!enabled) {
      return const EnvironmentConfig(
        enabled: false,
        configurations: {},
      );
    }

    final configurations = <String, EnvironmentDetails>{};

    for (final target in flavors.flavors) {
      LoggerService.blank();
      LoggerService.command(target);

      configurations[target] = EnvironmentDetails(
        file: PromptService.ask(
          'Environment file path',
          defaultValue: _defaultPath(target),
        ),
      );
    }

    return EnvironmentConfig(
      enabled: true,
      configurations: configurations,
    );
  }

  String _defaultPath(String target) {
    if (!flavors.enabled) {
      return 'env/env.json';
    }

    return 'env/$target.json';
  }
}
