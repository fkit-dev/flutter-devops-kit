import '../models/init_config.dart';
import 'sections/build_section.dart';
import 'sections/entry_section.dart';
import 'sections/firebase_section.dart';
import 'sections/flavor_section.dart';
import 'sections/generator_config_section.dart';
import 'sections/localization_section.dart';
import 'sections/platform_section.dart';
import 'sections/project_section.dart';
import 'sections/tooling_section.dart';

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
