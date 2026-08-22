/// Common option parsing for commands that support non-interactive generation.
class CommandArgs {
  const CommandArgs._();

  /// Returns whether [args] contains the named flag.
  static bool hasFlag(List<String> args, String flag) => args.contains(flag);

  /// Returns positional arguments, excluding known generation flags.
  static List<String> positional(List<String> args) {
    return args
        .where((arg) =>
            arg != '--yes' && arg != '--force' && arg != '--no-build-runner')
        .toList();
  }
}
