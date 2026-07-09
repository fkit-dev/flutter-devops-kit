import '../../../models/init_config.dart';
import 'generator_section.dart';

class PlatformSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('platforms:');
    buffer.writeln('  android: ${config.android}');
    buffer.writeln('  ios: ${config.ios}');
    buffer.writeln('  web: ${config.web}');
  }
}
