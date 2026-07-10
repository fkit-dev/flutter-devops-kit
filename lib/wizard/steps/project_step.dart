import 'package:flutter_devops_kit/wizard/wizard_step.dart';

import '../../services/prompt_service.dart';

/// Collects project configuration during the initialization wizard.
class ProjectStep extends WizardStep<String> {
  @override
  String collect() {
    return PromptService.ask(
      'Project name',
    );
  }
}
