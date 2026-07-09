import '../../../models/init_config.dart';
import 'generator_section.dart';

class EntrySection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('entry:');
    buffer.writeln('  main: lib/main.dart');
  }
}
