import '../../../models/flavor_details.dart';
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

    buffer.writeln();

    buffer.writeln('flavors:');
    buffer.writeln('  default: ${config.defaultFlavor}');

    for (final entry in config.flavors.entries) {
      final FlavorDetails flavor = entry.value;

      buffer.writeln();
      buffer.writeln('  ${entry.key}:');
      buffer.writeln('    env: ${flavor.env}');
      buffer.writeln();
      buffer.writeln('    firebase:');

      if (config.android) {
        buffer.writeln('      android:');
        buffer.writeln(
          '        app_id: ${flavor.firebase.android.appId}',
        );
        buffer.writeln(
          '        options: ${flavor.firebase.android.options}',
        );
      }

      if (config.ios) {
        buffer.writeln();
        buffer.writeln('      ios:');
        buffer.writeln(
          '        app_id: ${flavor.firebase.ios.appId}',
        );
        buffer.writeln(
          '        options: ${flavor.firebase.ios.options}',
        );
      }

      if (config.web) {
        buffer.writeln();
        buffer.writeln('      web:');
        buffer.writeln(
          '        app_id: ${flavor.firebase.web.appId}',
        );
        buffer.writeln(
          '        options: ${flavor.firebase.web.options}',
        );
      }
    }
  }
}
