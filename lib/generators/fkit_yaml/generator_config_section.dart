import '../../models/init_config.dart';
import 'generator_section.dart';

class GeneratorConfigSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('generator:');
    buffer.writeln(
      '  default_template: ${config.defaultTemplate}',
    );
  }
}
