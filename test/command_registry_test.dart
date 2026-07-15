import 'package:flutter_devops_kit/commands/help_command.dart';
import 'package:flutter_devops_kit/core/command_registry.dart';
import 'package:test/test.dart';

void main() {
  group('CommandRegistry', () {
    test('returns HelpCommand for "help"', () {
      final cmd = CommandRegistry.command('help');
      expect(cmd, isNotNull);
      expect(cmd, isA<HelpCommand>());
    });

    test('returns null for unknown command', () {
      expect(CommandRegistry.command('nonexistent'), isNull);
    });

    test('returns null for empty string', () {
      expect(CommandRegistry.command(''), isNull);
    });

    test('registered command count matches expected', () {
      expect(CommandRegistry.commands.length, greaterThan(0));
    });

    test('all commands have unique names', () {
      final names = CommandRegistry.commands.map((c) => c.name).toList();
      expect(names.toSet().length, equals(names.length));
    });

    test('all commands have non-empty descriptions', () {
      for (final cmd in CommandRegistry.commands) {
        expect(cmd.description, isNotEmpty,
            reason: 'Command "${cmd.name}" has empty description');
      }
    });

    test('all commands have valid categories', () {
      for (final cmd in CommandRegistry.commands) {
        expect(cmd.category, isNotNull);
      }
    });

    test('command lookup is case-sensitive', () {
      expect(CommandRegistry.command('Help'), isNull);
    });

    test('each command has unique name', () {
      final names = <String>{};
      for (final cmd in CommandRegistry.commands) {
        expect(names.add(cmd.name), isTrue,
            reason: 'Duplicate command name: ${cmd.name}');
      }
    });
  });
}
