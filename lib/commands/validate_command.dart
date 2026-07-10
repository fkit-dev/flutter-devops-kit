import '../core/command.dart';
import '../core/command_category.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';
import '../validators/init_validator.dart';

/// Validates the current FKIT project configuration.
///
/// Checks the project configuration for invalid or unsupported settings.
class ValidateCommand extends Command {
  @override
  String get name => 'validate';

  @override
  String get description => 'Validate project configuration';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit validate';

  @override
  List<String> get examples => const [
        'fkit validate',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section(
      'Validating project',
    );

    final config = await ConfigService.load();

    InitValidator.validate(
      config,
    );

    LoggerService.blank();

    LoggerService.success(
      'Project validation complete.',
    );

    LoggerService.blank();
  }
}
