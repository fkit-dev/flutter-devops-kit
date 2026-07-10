import 'package:args/args.dart';

import 'command.dart';

/// Defines a base command that parses command-line arguments before execution.
abstract class BaseArgCommand extends Command {
  /// Creates the argument parser used by this command.
  ArgParser buildParser();

  /// Executes the command using the parsed [results].
  Future<void> execute(ArgResults results);

  /// Parses the provided command-line [args] and executes the command.
  @override
  Future<void> run(List<String> args) async {
    final parser = buildParser();

    final results = parser.parse(args);

    await execute(results);
  }
}
