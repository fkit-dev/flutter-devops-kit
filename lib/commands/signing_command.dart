import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../services/logger_service.dart';
import '../services/signing_service.dart';

class SigningCommand extends BaseArgCommand {
  @override
  String get name => 'signing';

  @override
  String get description => 'Android signing utilities';

  @override
  CommandCategory get category => CommandCategory.environment;

  @override
  String get usage => 'fkit signing <setup|doctor>';

  @override
  List<String> get examples => const [
        'fkit signing setup',
        'fkit signing doctor',
      ];

  @override
  bool get requiresFlutterProject => true;

  @override
  ArgParser buildParser() => ArgParser();

  @override
  Future<void> execute(ArgResults results) async {
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
        '  doctor',
      );

      return;
    }

    final action = results.rest.first.toLowerCase();

    final service = SigningService();

    switch (action) {
      case 'setup':
        await service.setup();
        break;

      case 'doctor':
        await service.doctor();
        break;

      default:
        LoggerService.error(
          'Unknown signing command: $action',
        );

        LoggerService.blank();

        LoggerService.info(
          'Available commands:',
        );

        LoggerService.info(
          '  setup',
        );

        LoggerService.info(
          '  doctor',
        );
    }
  }
}
