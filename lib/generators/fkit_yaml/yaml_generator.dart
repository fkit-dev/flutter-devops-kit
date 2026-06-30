import '../../models/init_config.dart';
import 'build_section.dart';
import 'entry_section.dart';
import 'firebase_section.dart';
import 'flavor_section.dart';
import 'generator_config_section.dart';
import 'localization_section.dart';
import 'platform_section.dart';
import 'project_section.dart';
import 'tooling_section.dart';

class YamlGenerator {
  static final _sections = [
    ProjectSection(),
    ToolingSection(),
    PlatformSection(),
    BuildSection(),
    EntrySection(),
    FlavorSection(),
    LocalizationSection(),
    FirebaseSection(),
    GeneratorConfigSection(),
  ];

  static String generate(InitConfig config) {
    final buffer = StringBuffer();

    for (final section in _sections) {
      section.write(
        buffer,
        config,
      );
      buffer.writeln();
    }

    return buffer.toString();
  }
}
