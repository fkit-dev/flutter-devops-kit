import '../../models/init_config.dart';
import 'generator_section.dart';

class LocalizationSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    buffer.writeln('localization:');
    buffer.writeln('  enabled: ${config.localizationEnabled}');
    buffer.writeln();

    buffer.writeln('  arb_dir: ${config.arbDir}');
    buffer.writeln(
      '  template: app_${config.defaultLocale}.arb',
    );
    buffer.writeln('  output_dir: ${config.outputDir}');
    buffer.writeln('  output_file: ${config.outputFile}');
    buffer.writeln(
      '  default_locale: ${config.defaultLocale}',
    );

    buffer.writeln();
    buffer.writeln('  locales:');

    for (final locale in config.locales) {
      buffer.writeln('    - $locale');
    }
  }
}
