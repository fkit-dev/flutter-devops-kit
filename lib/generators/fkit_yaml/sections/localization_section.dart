import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the localization configuration section of the FKIT YAML file.
class LocalizationSection extends GeneratorSection {
  @override
  void write(StringBuffer buffer, InitConfig config) {
    final localization = config.localization;

    buffer.writeln('localization:');
    buffer.writeln('  enabled: ${localization.enabled}');
    buffer.writeln();

    buffer.writeln('  arb_dir: ${localization.arbDir}');
    buffer.writeln('  template: ${localization.templateArb}');
    buffer.writeln('  output_dir: ${localization.outputDir}');
    buffer.writeln('  output_file: ${localization.outputFile}');
    buffer.writeln('  default_locale: ${localization.defaultLocale}');

    buffer.writeln();
    buffer.writeln('  locales:');

    for (final locale in localization.locales) {
      buffer.writeln('    - $locale');
    }
  }
}
