class YamlGenerator {
  static String generate({
    required String projectName,
    required bool useFvm,
    required bool android,
    required bool ios,
    required bool web,
    required bool flavoringEnabled,
    required String defaultFlavor,
    required Map<String, Map<String, dynamic>> flavors,
  }) {
    final buffer = StringBuffer();

    buffer.writeln('project_name: $projectName');

    buffer.writeln();

    buffer.writeln('tooling:');
    buffer.writeln('  use_fvm: $useFvm');

    buffer.writeln();

    buffer.writeln('platforms:');
    buffer.writeln('  android: $android');
    buffer.writeln('  ios: $ios');
    buffer.writeln('  web: $web');

    buffer.writeln();

    buffer.writeln('build:');
    buffer.writeln('  debug_info: ./debug-info');
    buffer.writeln('  obfuscate: true');

    buffer.writeln();

    buffer.writeln('entry:');
    buffer.writeln('  main: lib/main.dart');

    buffer.writeln();

    buffer.writeln('flavoring:');
    buffer.writeln('  enabled: $flavoringEnabled');

    buffer.writeln();

    buffer.writeln('flavors:');
    buffer.writeln('  default: $defaultFlavor');

    for (final flavor in flavors.entries) {
      buffer.writeln();

      buffer.writeln('  ${flavor.key}:');

      buffer.writeln('    env: ${flavor.value['env']}');

      buffer.writeln();

      buffer.writeln('    firebase:');

      buffer.writeln(
        '      app_distribution_id: '
        '${flavor.value['appId']}',
      );

      buffer.writeln();

      buffer.writeln('      options:');

      final options = flavor.value['firebaseOptions'] as Map<String, dynamic>;

      buffer.writeln('        android: ${options['android']}');

      buffer.writeln('        ios: ${options['ios']}');

      buffer.writeln('        web: ${options['web']}');
    }

    buffer.writeln();

    buffer.writeln('firebase:');
    buffer.writeln('  tester_group: internal-testers');

    buffer.writeln();

    buffer.writeln('generator:');
    buffer.writeln('  default_template: riverpod_clean');

    return buffer.toString();
  }
}
