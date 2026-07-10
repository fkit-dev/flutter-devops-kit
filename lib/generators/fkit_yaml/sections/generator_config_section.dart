import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the code generator configuration section of the FKIT YAML file.
class GeneratorConfigSection extends GeneratorSection {
  @override
  void write(StringBuffer buffer, InitConfig config) {
    buffer.writeln('generator:');
    buffer.writeln('  feature_dir: ${config.featureDir}');
    buffer.writeln('  default_template: ${config.defaultTemplate}');
  }
}
