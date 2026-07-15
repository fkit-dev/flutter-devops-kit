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

  /// The existing environment configuration.
  final EnvironmentConfig? current;

  /// Creates an environment configuration step.
  EnvironmentStep({required this.flavors, this.current});

  @override
  EnvironmentConfig collect() {
    LoggerService.blank();
    LoggerService.info('Environment');

    final enabled = PromptService.confirm('Does project use environment files?', defaultValue: current?.enabled ?? true);

    if (!enabled) {
      return const EnvironmentConfig(enabled: false, configurations: {});
    }

    final configurations = <String, EnvironmentDetails>{};

    for (final target in flavors.flavors) {
      LoggerService.blank();
      LoggerService.command(target);

      final currentDetails = current?.configurationFor(target);

      configurations[target] = EnvironmentDetails(
          file: PromptService.ask('Environment file path', defaultValue: _resolvePath(target: target, current: currentDetails)));
    }

    return EnvironmentConfig(enabled: true, configurations: configurations);
  }

  String _resolvePath({required String target, EnvironmentDetails? current}) {
    if (current != null && current.file.isNotEmpty) return current.file;
    if (!flavors.enabled) return 'env/env.json';
    return 'env/$target.json';
  }
}
