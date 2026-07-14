import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/flavor_setup.dart';
import '../wizard_step.dart';

/// Collects flavor configuration during the initialization wizard.
class FlavorStep extends WizardStep<FlavorSetup> {
  @override
  FlavorSetup collect() {
    LoggerService.blank();
    LoggerService.info('Flavors');

    final enabled = PromptService.confirm('Does project use flavors?', defaultValue: false);

    if (!enabled) {
      LoggerService.info('Using default target: main');

      return const FlavorSetup(enabled: false, defaultFlavor: 'main', flavors: ['main']);
    }

    final flavorsInput = PromptService.ask('Flavors (comma separated)', defaultValue: 'development,staging,production');

    final flavors = flavorsInput.split(',').map((value) => value.trim()).where((value) => value.isNotEmpty).toSet().toList();

    if (flavors.isEmpty) {
      LoggerService.warning('No valid flavors provided. Using default target: main');

      return const FlavorSetup(enabled: false, defaultFlavor: 'main', flavors: ['main']);
    }

    final requestedDefaultFlavor = PromptService.ask('Default flavor', defaultValue: flavors.first);

    final defaultFlavor = flavors.contains(requestedDefaultFlavor) ? requestedDefaultFlavor : flavors.first;

    if (defaultFlavor != requestedDefaultFlavor) {
      LoggerService.warning('Unknown default flavor "$requestedDefaultFlavor". '
          'Using "$defaultFlavor" instead.');
    }

    return FlavorSetup(
      enabled: true,
      defaultFlavor: defaultFlavor,
      flavors: flavors,
    );
  }
}
