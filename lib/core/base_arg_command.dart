import 'package:args/args.dart';

import 'command.dart';

abstract class BaseArgCommand extends Command {
  ArgParser buildParser();

  Future<void> execute(ArgResults results);

  @override
  Future<void> run(List<String> args) async {
    final parser = buildParser();

    final results = parser.parse(args);

    await execute(results);
  }
}
