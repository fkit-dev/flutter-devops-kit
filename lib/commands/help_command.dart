import '../core/command.dart';
import '../core/command_category.dart';
import '../core/command_registry.dart';
import '../services/logger_service.dart';

class HelpCommand extends Command {
  @override
  String get name => 'help';

  @override
  String get description => 'Show all available commands';

  @override
  CommandCategory get category => CommandCategory.project;

  @override
  String get usage => 'fkit help';

  @override
  List<String> get examples => const ['fkit help'];

  @override
  Future<void> run(List<String> args) async {
    LoggerService.section('Flutter DevOps Kit (FKIT)');

    final commands = CommandRegistry.commands.where((e) => e.name != name).toList()
      ..sort((a, b) {
        final category = a.category.index.compareTo(b.category.index);
        if (category != 0) return category;
        return a.name.compareTo(b.name);
      });

    CommandCategory? previousCategory;

    for (final command in commands) {
      if (previousCategory != command.category) {
        if (previousCategory != null) LoggerService.blank();

        LoggerService.info(command.category.title);
        LoggerService.blank();
        previousCategory = command.category;
      }
      final width = commands.map((e) => e.usage.length).reduce((a, b) => a > b ? a : b);
      LoggerService.info('${command.usage.padRight(width + 2)}${command.description}');
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
    LoggerService.info('Tip: Flavor is optional for projects without flavors.');
    LoggerService.blank();
  }
}
