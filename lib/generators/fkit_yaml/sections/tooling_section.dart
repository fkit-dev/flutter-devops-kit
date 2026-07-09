import '../../../models/init_config.dart';
import 'generator_section.dart';

class ToolingSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('tooling:');
    buffer.writeln('  use_fvm: ${config.useFvm}');
  }
}
