import 'package:flutter_devops_kit/commands/analyze_command.dart';
import 'package:flutter_devops_kit/commands/build_command.dart';
import 'package:flutter_devops_kit/commands/clean_command.dart';
import 'package:flutter_devops_kit/commands/config_command.dart';
import 'package:flutter_devops_kit/commands/doctor_command.dart';
import 'package:flutter_devops_kit/commands/extension_command.dart';
import 'package:flutter_devops_kit/commands/feature_command.dart';
import 'package:flutter_devops_kit/commands/firebase_command.dart';
import 'package:flutter_devops_kit/commands/fix_command.dart';
import 'package:flutter_devops_kit/commands/format_command.dart';
import 'package:flutter_devops_kit/commands/generate_command.dart';
import 'package:flutter_devops_kit/commands/get_command.dart';
import 'package:flutter_devops_kit/commands/help_command.dart';
import 'package:flutter_devops_kit/commands/init_command.dart';
import 'package:flutter_devops_kit/commands/localization_command.dart';
import 'package:flutter_devops_kit/commands/run_command.dart';
import 'package:flutter_devops_kit/commands/signing_command.dart';
import 'package:flutter_devops_kit/commands/validate_command.dart';
import 'package:flutter_devops_kit/commands/watch_command.dart';

Future<void> main(List<String> args) async {
  final commands = {
    'init': InitCommand(),
    'feat': FeatureCommand(),
    'help': HelpCommand(),
    'doctor': DoctorCommand(),
    'clean': CleanCommand(),
    'config': ConfigCommand(),
    'l10n': LocalizationCommand(),
    'get': GetCommand(),
    'fix': FixCommand(),
    'analyze': AnalyzeCommand(),
    'format': FormatCommand(),
    'run': RunCommand(),
    'build': BuildCommand(),
    'firebase': FirebaseCommand(),
    'generate': GenerateCommand(),
    'watch': WatchCommand(),
    'validate': ValidateCommand(),
    'signing': SigningCommand(),
    'extension': ExtensionCommand(),
  };

  if (args.isEmpty) {
    await commands['help']!.run([]);
    return;
  }

  final commandName = args.first;

  if (!commands.containsKey(commandName)) {
    print('❌ Unknown command: $commandName\n');
    await commands['help']!.run([]);
    return;
  }

  await commands[commandName]!.run(args.skip(1).toList());
}
