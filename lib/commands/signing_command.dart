import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../services/logger_service.dart';
import '../services/signing_service.dart';

class SigningCommand extends BaseArgCommand {
  @override
  String get name => 'signing';

  @override
  String get description => 'Android signing utilities';

  @override
  ArgParser buildParser() {
    return ArgParser();
  }

  @override
  Future<void> execute(ArgResults results) async {
    if (results.rest.isEmpty) {
      LoggerService.error('Usage: fkit signing <setup|doctor>');

      return;
    }

    final action = results.rest.first;

    final service = SigningService();

    switch (action) {
      case 'setup':
        await service.setup();
        break;

      case 'doctor':
        await service.doctor();
        break;

      default:
        LoggerService.error('Unknown signing command: $action');
    }
  }
}
