import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the application entry-point configuration section of the FKIT YAML file.
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
