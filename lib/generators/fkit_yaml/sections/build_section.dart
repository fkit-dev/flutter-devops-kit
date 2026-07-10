import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the build configuration section of the FKIT YAML file.
class BuildSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('build:');
    buffer.writeln('  debug_info: ./debug-info');
    buffer.writeln('  obfuscate: true');
  }
}
