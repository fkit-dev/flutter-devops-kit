import 'dart:io';

import 'constructor_parameter.dart';

class ConstructorResolver {
  const ConstructorResolver();

  Future<List<ConstructorParameter>> resolve(File file) async {
    if (!file.existsSync()) return const [];

    final content = await file.readAsString();

    final constructor = RegExp(r'(?:const\s+)?\w+\s*\(\{([\s\S]*?)\}\)', multiLine: true);

    final match = constructor.firstMatch(content);

    if (match == null) return const [];

    final body = match.group(1)!;

    final parameters = <ConstructorParameter>[];

    for (final rawLine in body.split('\n')) {
      var line = rawLine.trim();

      if (line.isEmpty) continue;

      // remove trailing comma
      if (line.endsWith(',')) line = line.substring(0, line.length - 1);

      final isRequired = line.startsWith('required ');

      if (isRequired) line = line.substring('required '.length);

      final parts = line.split(RegExp(r'\s+'));

      if (parts.length != 2) continue;

      parameters.add(ConstructorParameter(type: parts[0], name: parts[1], isNamed: true, isRequired: isRequired));
    }

    return parameters;
  }
}
