import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the platform configuration section of the FKIT YAML file.
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
