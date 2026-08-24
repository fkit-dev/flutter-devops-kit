import '../commands/analyze_command.dart';
import '../commands/build_command.dart';
import '../commands/clean_command.dart';
import '../commands/config_command.dart';
import '../commands/doctor_command.dart';
import '../commands/extension_command.dart';
import '../commands/feature_command.dart';
import '../commands/firebase_command.dart';
import '../commands/fix_command.dart';
import '../commands/format_command.dart';
import '../commands/generate_command.dart';
import '../commands/get_command.dart';
import '../commands/help_command.dart';
import '../commands/icon_command.dart';
import '../commands/init_command.dart';
import '../commands/install_command.dart';
import '../commands/localization_command.dart';
import '../commands/make_command.dart';
import '../commands/run_command.dart';
import '../commands/setup_command.dart';
import '../commands/signing_command.dart';
import '../commands/validate_command.dart';
import '../commands/watch_command.dart';
import 'command.dart';

/// Provides access to the commands supported by FKIT.
class CommandRegistry {
  const CommandRegistry._();

  /// The commands registered with the FKIT command-line interface.
  static final List<Command> commands = [
    AnalyzeCommand(),
    CleanCommand(),
    ConfigCommand(),
    BuildCommand(),
    DoctorCommand(),
    ExtensionCommand(),
    FeatureCommand(),
    FirebaseCommand(),
    FixCommand(),
    FormatCommand(),
    GenerateCommand(),
    GetCommand(),
    HelpCommand(),
    InitCommand(),
    LocalizationCommand(),
    RunCommand(),
    SigningCommand(),
    ValidateCommand(),
    WatchCommand(),
    MakeCommand(),
    InstallCommand(),
    IconCommand(),
    SetupCommand(),
  ];

  /// Returns the command registered with the specified [name].
  ///
  /// Returns `null` when no matching command is registered.
  static Command? command(String name) {
    for (final command in commands) {
      if (command.name == name) return command;
      if (command.aliases.contains(name)) return command;
    }
    return null;
  }

  /// Returns close command names for an unknown [name].
  static List<String> suggestions(String name) {
    if (name.trim().isEmpty) return const [];

    final normalized = name.toLowerCase();
    final matches = <String>[];

    for (final command in commands) {
      final candidates = [command.name, ...command.aliases];
      if (candidates.any(
        (candidate) =>
            candidate.startsWith(normalized) ||
            normalized.startsWith(candidate) ||
            _distance(candidate, normalized) <= 2,
      )) {
        matches.add(command.name);
      }
    }

    matches.sort();
    return matches.take(3).toList();
  }

  static int _distance(String a, String b) {
    final previous = List<int>.generate(b.length + 1, (index) => index);
    final current = List<int>.filled(b.length + 1, 0);

    for (var i = 1; i <= a.length; i++) {
      current[0] = i;
      for (var j = 1; j <= b.length; j++) {
        final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
        current[j] = [
          current[j - 1] + 1,
          previous[j] + 1,
          previous[j - 1] + cost,
        ].reduce((value, element) => value < element ? value : element);
      }
      previous.setAll(0, current);
    }

    return previous[b.length];
  }
}
