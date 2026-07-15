import '../../../models/firebase/firebase_platform.dart';
import '../../../models/init_config.dart';
import 'generator_section.dart';

/// Generates the Firebase configuration section of the FKIT YAML file.
class FirebaseSection extends GeneratorSection {
  @override
  void write(
    StringBuffer buffer,
    InitConfig config,
  ) {
    final firebase = config.firebase;

    buffer.writeln('firebase:');
    buffer.writeln('  enabled: ${firebase.enabled}');
    buffer.writeln('  tester_group: ${firebase.testerGroup}');

    if (firebase.configurations.isEmpty) {
      buffer.writeln('  configurations: {}');
      return;
    }

    buffer.writeln();
    buffer.writeln('  configurations:');

    for (final entry in firebase.configurations.entries) {
      buffer.writeln('    ${entry.key}:');

      final details = entry.value;

      _writePlatform(
        buffer,
        name: 'android',
        platform: details.android,
      );

      _writePlatform(
        buffer,
        name: 'ios',
        platform: details.ios,
      );

      _writePlatform(
        buffer,
        name: 'web',
        platform: details.web,
      );
    }
  }

  void _writePlatform(
    StringBuffer buffer, {
    required String name,
    required FirebasePlatform? platform,
  }) {
    if (platform == null) {
      return;
    }

    buffer.writeln('      $name:');
    buffer.writeln('        app_id: ${platform.appId}');
    buffer.writeln('        options: ${platform.options}');
  }
}
