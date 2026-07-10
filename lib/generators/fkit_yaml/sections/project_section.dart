import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the project configuration section of the FKIT YAML file.
class ProjectSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('project_name: ${config.projectName}');
  }
}
