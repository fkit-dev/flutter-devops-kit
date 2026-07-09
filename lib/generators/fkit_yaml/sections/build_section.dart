import '../../../models/init_config.dart';
import 'generator_section.dart';

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
