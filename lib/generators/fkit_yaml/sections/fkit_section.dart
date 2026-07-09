import '../../../models/init_config.dart';
import 'generator_section.dart';

class FkitSection extends GeneratorSection {
  @override
  void write(StringBuffer buffer, InitConfig config) {
    buffer.writeln('fkit:');
    buffer.writeln('  version: ${config.version}');
  }
}
