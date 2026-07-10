import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../wizard_step.dart';

/// Collects Firebase configuration during the initialization wizard.
class FirebaseStep extends WizardStep<String> {
  @override
  String collect() {
    LoggerService.blank();
    LoggerService.info('Firebase');
    return PromptService.ask(
      'Default Firebase tester group',
      defaultValue: 'internal-testers',
    );
  }
}
