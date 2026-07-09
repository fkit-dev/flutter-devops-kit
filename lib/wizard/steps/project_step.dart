import 'package:flutter_devops_kit/wizard/wizard_step.dart';

import '../../services/prompt_service.dart';

class ProjectStep extends WizardStep<String> {
  @override
  String collect() {
    return PromptService.ask(
      'Project name',
    );
  }
}
