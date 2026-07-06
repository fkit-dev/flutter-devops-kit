import 'package:flutter_devops_kit/commands/icon_command.dart';

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
import '../commands/init_command.dart';
import '../commands/install_command.dart';
import '../commands/localization_command.dart';
import '../commands/make_command.dart';
import '../commands/run_command.dart';
import '../commands/signing_command.dart';
import '../commands/validate_command.dart';
import '../commands/watch_command.dart';
import 'command.dart';

class CommandRegistry {
  const CommandRegistry._();

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
  ];

  static Command? command(String name) {
    for (final command in commands) {
      if (command.name == name) return command;
    }
    return null;
  }
}
