import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/generator_setup.dart';
import '../wizard_step.dart';

class GeneratorStep extends WizardStep<GeneratorSetup> {
  @override
  GeneratorSetup collect() {
    LoggerService.blank();

    LoggerService.info('Generator');

    final template = PromptService.ask(
      'Default template',
      defaultValue: 'riverpod_clean',
    );

    return GeneratorSetup(
      defaultTemplate: template,
    );
  }
}
