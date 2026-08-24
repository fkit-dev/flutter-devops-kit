import '../core/command.dart';
import '../core/command_category.dart';
import '../core/command_registry.dart';
import '../services/logger_service.dart';

/// Displays usage information for FKIT commands.
///
/// Provides command descriptions, usage syntax, aliases, and examples.
class HelpCommand extends Command {
  @override
  String get name => 'help';

  @override
  String get description => 'Show help information';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit help [command]';

  @override
  List<String> get examples =>
      const ['fkit help', 'fkit help make', 'fkit help feat'];

  @override
  Future<void> run(List<String> args) async {
    if (args.isNotEmpty) {
      _showCommandHelp(args.first);
      return;
    }

    _showGeneralHelp();
  }

  // ---------------------------------------------------------------------------
  // General Help
  // ---------------------------------------------------------------------------

  void _showGeneralHelp() {
    LoggerService.section('Flutter DevOps Kit (FKIT)');

    final commands =
        CommandRegistry.commands.where((e) => e.name != name).toList()
          ..sort((a, b) {
            final category = a.category.index.compareTo(b.category.index);

            if (category != 0) return category;

            return a.name.compareTo(b.name);
          });

    final usageWidth =
        commands.map((e) => e.usage.length).reduce((a, b) => a > b ? a : b);

    CommandCategory? previous;

    for (final command in commands) {
      if (previous != command.category) {
        if (previous != null) LoggerService.blank();

        LoggerService.info(command.category.title);
        LoggerService.blank();

        previous = command.category;
      }

      LoggerService.info('${command.usage.padRight(usageWidth + 2)}'
          '${command.description}');
    }

    LoggerService.blank();

    LoggerService.info('Examples');
    LoggerService.blank();

    final examples = <String>{};

    for (final command in commands) {
      examples.addAll(command.examples);
    }

    for (final example in examples) {
      LoggerService.info(example);
    }

    LoggerService.blank();
    LoggerService.info('Run "fkit help <command>" for detailed usage.');
    LoggerService.blank();
  }

  // ---------------------------------------------------------------------------
  // Command Help
  // ---------------------------------------------------------------------------

  void _showCommandHelp(String commandName) {
    final command = CommandRegistry.commands
        .where((e) => e.name == commandName)
        .firstOrNull;

    if (command == null) {
      LoggerService.error('Unknown command "$commandName".');
      LoggerService.blank();
      final suggestions = CommandRegistry.suggestions(commandName);
      if (suggestions.isNotEmpty) {
        LoggerService.info('Did you mean: ${suggestions.join(', ')}?');
        LoggerService.blank();
      }
      LoggerService.info('Run "fkit help" to see all commands.');

      return;
    }

    LoggerService.section(command.name);

    LoggerService.info(command.description);

    LoggerService.blank();

    LoggerService.info('Usage');
    LoggerService.blank();
    LoggerService.info(command.usage);

    LoggerService.blank();

    if (command.examples.isNotEmpty) {
      LoggerService.info('Examples');
      LoggerService.blank();

      for (final example in command.examples) {
        LoggerService.info(example);
      }

      LoggerService.blank();
    }

    LoggerService.info('Category');
    LoggerService.blank();
    LoggerService.info(command.category.title);

    LoggerService.blank();
  }
}
