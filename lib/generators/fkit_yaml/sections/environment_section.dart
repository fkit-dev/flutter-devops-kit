import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the environment configuration section of the FKIT YAML file.
class EnvironmentSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    final environment = config.environment;

    buffer.writeln('environment:');
    buffer.writeln('  enabled: ${environment.enabled}');

    if (environment.configurations.isEmpty) {
      buffer.writeln('  configurations: {}');
      return;
    }

    buffer.writeln();
    buffer.writeln('  configurations:');

    for (final entry in environment.configurations.entries) {
      buffer.writeln('    ${entry.key}:');
      buffer.writeln('      file: ${entry.value.file}');
    }
  }
}
