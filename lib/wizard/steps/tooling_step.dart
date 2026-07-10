import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../wizard_step.dart';

/// Collects tooling configuration during the initialization wizard.
class ToolingStep extends WizardStep<bool> {
  @override
  bool collect() {
    LoggerService.blank();
    LoggerService.info('Tooling');
    return PromptService.confirm(
      'Use FVM?',
      defaultValue: false,
    );
  }
}
