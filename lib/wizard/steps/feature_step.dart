import 'package:flutter_devops_kit/wizard/wizard_step.dart';

import '../../services/prompt_service.dart';

/// Collects feature configuration during the initialization wizard.
class FeatureStep extends WizardStep<String> {
  @override
  String collect() =>
      PromptService.ask('Feature Path', defaultValue: 'lib/features');
}
