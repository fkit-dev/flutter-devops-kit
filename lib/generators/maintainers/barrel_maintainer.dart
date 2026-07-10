import 'dart:io';

import '../core/generator_context.dart';
import 'maintainer.dart';

/// Maintains barrel export files for generated features.
///
/// Synchronizes exports according to the barrel configuration defined by the
/// selected template.
class BarrelMaintainer implements Maintainer {
  @override
  Future<void> maintain(GeneratorContext context) async {
    final barrel = context.template.barrel;

    final exports = <String>{};

    for (final folder in barrel.exports) {
      final directory = Directory('${context.featurePath}/$folder');

      if (!directory.existsSync()) continue;

      final files = directory
          .listSync()
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart') && !file.path.endsWith('.g.dart') && !file.path.endsWith('.freezed.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

      for (final file in files) {
        final relative = file.path.replaceFirst('${context.featurePath}/', '').replaceAll('\\', '/');
        exports.add("export '$relative';");
      }
    }

    final buffer = StringBuffer();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln();

    for (final export in exports) {
      buffer.writeln(export);
    }

    final output = File('${context.featurePath}/${barrel.file}');
    await output.writeAsString('$buffer');
  }
}
