import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the Firebase configuration section of the FKIT YAML file.
class FirebaseSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('firebase:');
    buffer.writeln('  tester_group: internal-testers');
  }
}
