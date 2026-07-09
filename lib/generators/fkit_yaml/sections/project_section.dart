import '../../../models/init_config.dart';
import 'generator_section.dart';

class ProjectSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('project_name: ${config.projectName}');
  }
}
