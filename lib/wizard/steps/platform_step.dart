import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/platform_setup.dart';
import '../wizard_step.dart';

/// Collects platform configuration during the initialization wizard.
class PlatformStep extends WizardStep<PlatformSetup> {
  @override
  PlatformSetup collect() {
    LoggerService.blank();

    LoggerService.info('Platforms');

    return PlatformSetup(
      android: PromptService.confirm(
        'Enable Android?',
        defaultValue: true,
      ),
      ios: PromptService.confirm(
        'Enable iOS?',
        defaultValue: true,
      ),
      web: PromptService.confirm(
        'Enable Web?',
        defaultValue: true,
      ),
    );
  }
}
