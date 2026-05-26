import '../core/command.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';
import '../validators/project_validator.dart';

class ValidateCommand extends Command {
  @override
  String get name => 'validate';

  @override
  String get description => 'Validate project configuration';

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Validating project');

    final config = await ConfigService.load();

    ProjectValidator.validate(config);

    LoggerService.blank();

    LoggerService.success('Project validation complete.');

    LoggerService.blank();
  }
}
