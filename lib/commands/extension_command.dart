import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../services/extension_service.dart';
import '../services/logger_service.dart';

/// Generates extension files for FKIT projects.
///
/// Supports generating configured utility extensions for the current project.
class ExtensionCommand extends BaseArgCommand {
  @override
  String get name => 'extension';

  @override
  String get description => 'Generate common Flutter extensions';

  @override
  CommandCategory get category => CommandCategory.codeGeneration;

  @override
  String get usage => 'fkit extension <generate>';

  @override
  List<String> get examples => const [
        'fkit extension generate',
      ];

  @override
  bool get requiresConfig => true;

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
      return;
    }

    switch (results.rest.first.toLowerCase()) {
      case 'generate':
        await ExtensionService().generate();
        break;

      default:
        LoggerService.error(
          'Unknown extension command: ${results.rest.first}',
        );

        LoggerService.info(
          'Available commands:',
        );

        LoggerService.info(
          '  generate',
        );
    }
  }
}
