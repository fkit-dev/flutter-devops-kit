import 'dart:io';

import 'package:flutter_devops_kit/core/command_registry.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    await CommandRegistry.command('help')!.run([]);
    return;
  }

  final command = CommandRegistry.command(args.first);

  if (command == null) {
    print('❌ Unknown command: ${args.first}\n');
    await CommandRegistry.command('help')!.run([]);
    exit(1);
  }

  try {
    await command.run(args.skip(1).toList());
  } catch (e) {
    print('❌ $e');
    exit(1);
  }
}
