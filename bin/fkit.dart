import 'dart:io';

import 'package:flutter_devops_kit/core/command.dart';
import 'package:flutter_devops_kit/core/command_registry.dart';
import 'package:yaml/yaml.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    await CommandRegistry.command('help')!.run([]);
    return;
  }

  final command = CommandRegistry.command(args.first);

  if (command == null) {
    print('❌ Unknown command: ${args.first}\n');
    final suggestions = CommandRegistry.suggestions(args.first);
    if (suggestions.isNotEmpty) {
      print('Did you mean: ${suggestions.join(', ')}?\n');
    }
    await CommandRegistry.command('help')!.run([]);
    exit(1);
  }

  try {
    if (!_checkPreconditions(command)) {
      exit(1);
    }
    await command.run(args.skip(1).toList());
  } on FormatException catch (e) {
    print('❌ ${e.message}');
    exit(64);
  } catch (e) {
    print('❌ $e');
    exit(1);
  }
}

bool _checkPreconditions(Command command) {
  if (command.requiresFlutterProject && !File('pubspec.yaml').existsSync()) {
    print('❌ This command must be run from a Flutter project root.');
    print('');
    print('Run it in a directory containing pubspec.yaml.');
    print('For a new app, create one first with: flutter create <app_name>');
    return false;
  }

  if (command.requiresFlutterProject && !_looksLikeFlutterProject()) {
    print('❌ This directory does not look like a Flutter project.');
    print('');
    print('Expected pubspec.yaml to declare a Flutter SDK dependency.');
    return false;
  }

  if (command.requiresConfig && !File('fkit.yaml').existsSync()) {
    print('❌ fkit.yaml not found.');
    print('');
    print('Run "fkit init" first, or add an fkit.yaml to the project root.');
    return false;
  }

  return true;
}

bool _looksLikeFlutterProject() {
  try {
    final pubspec = loadYaml(File('pubspec.yaml').readAsStringSync());
    if (pubspec is! Map) return false;

    final dependencies = pubspec['dependencies'];
    if (dependencies is! Map || !dependencies.containsKey('flutter')) {
      return false;
    }

    final flutter = dependencies['flutter'];
    if (flutter is Map) {
      return flutter['sdk']?.toString() == 'flutter';
    }

    return true;
  } catch (_) {
    return false;
  }
}
