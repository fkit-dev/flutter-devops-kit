import 'package:flutter_devops_kit/commands/analyze_command.dart';
import 'package:flutter_devops_kit/commands/clean_command.dart';
import 'package:flutter_devops_kit/commands/config_command.dart';
import 'package:flutter_devops_kit/commands/doctor_command.dart';
import 'package:flutter_devops_kit/commands/fix_command.dart';
import 'package:flutter_devops_kit/commands/format_command.dart';
import 'package:flutter_devops_kit/commands/get_command.dart';
import 'package:flutter_devops_kit/commands/help_command.dart';

Future<void> main(List<String> args) async {
  final commands = {
    'help': HelpCommand(),
    'doctor': DoctorCommand(),
    'clean': CleanCommand(),
    'config': ConfigCommand(),
    'get': GetCommand(),
    'fix': FixCommand(),
    'analyze': AnalyzeCommand(),
    'format': FormatCommand(),
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
