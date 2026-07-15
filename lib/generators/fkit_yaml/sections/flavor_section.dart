import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the flavor configuration section of the FKIT YAML file.
class FlavorSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('flavoring:');
    buffer.writeln('  enabled: ${config.flavoringEnabled}');
    buffer.writeln('  default: ${config.defaultFlavor}');

    buffer.writeln();

    buffer.writeln('flavors:');

    for (final flavor in config.flavors) {
      buffer.writeln('  - $flavor');
    }
  }
}
