import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../services/config/config_service.dart';
import '../services/localization_service.dart';
import '../services/logger_service.dart';
import '../services/template_service.dart';

/// Manages localization workflows for FKIT projects.
///
/// Supports localization setup, generation, and validation operations.
class LocalizationCommand extends BaseArgCommand {
  @override
  String get name => 'l10n';

  @override
  String get description => 'Localization utilities';

  @override
  CommandCategory get category => CommandCategory.localization;

  @override
  String get usage => 'fkit l10n <command> [--yes|--force]';

  @override
  List<String> get examples => const [
        'fkit l10n setup',
        'fkit l10n generate',
        'fkit l10n doctor',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  ArgParser buildParser() => ArgParser()
    ..addFlag('yes', negatable: false)
    ..addFlag('force', negatable: false);

  @override
  Future<void> execute(
    ArgResults results,
  ) async {
    if (results.rest.isEmpty) {
      LoggerService.error(
        'Usage: $usage',
      );

      LoggerService.blank();

      LoggerService.info(
        'Available commands:',
      );

      LoggerService.info(
        '  setup',
      );

      LoggerService.info(
        '  generate',
      );

      LoggerService.info(
        '  doctor',
      );

      LoggerService.info(
        '  add',
      );

      LoggerService.info(
        '  validate',
      );

      LoggerService.info(
        '  extract',
      );

      return;
    }

    final config = await ConfigService.load();
    final template = await TemplateService.load(config.defaultTemplate);
    final appFilePath = template.setup.bootstrap.app?.output;
    final overwrite = results['yes'] == true || results['force'] == true;

    switch (results.rest.first.toLowerCase()) {
      case 'setup':
        await LocalizationService().generate(
          config: config,
          appFilePath: appFilePath,
          overwrite: overwrite,
        );
        break;

      case 'generate':
        await LocalizationService().generate(
          config: config,
          appFilePath: appFilePath,
          overwrite: overwrite,
        );
        break;

      case 'doctor':
        await LocalizationService().doctor();
        break;

      case 'add':
        LoggerService.warning(
          'Not implemented yet.',
        );
        break;

      case 'validate':
        LoggerService.warning(
          'Not implemented yet.',
        );
        break;

      case 'extract':
        LoggerService.warning(
          'Not implemented yet.',
        );
        break;

      default:
        LoggerService.error(
          'Unknown localization command: ${results.rest.first}',
        );

        LoggerService.blank();

        LoggerService.info(
          'Available commands:',
        );

        LoggerService.info(
          '  setup',
        );

        LoggerService.info(
          '  generate',
        );

        LoggerService.info(
          '  doctor',
        );
    }
  }
}
