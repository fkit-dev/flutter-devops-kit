import '../../../models/init_config.dart';
import 'generator_section.dart';

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
