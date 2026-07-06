import 'dart:io';

import 'package:yaml/yaml.dart';

import '../models/launcher_icon_config.dart';
import 'logger_service.dart';
import 'prompt_service.dart';

class LauncherIconService {
  const LauncherIconService();

  static const fileName = 'flutter_launcher_icons.yaml';

  File get _file => File(fileName);

  // ---------------------------------------------------------------------------
  // Public
  // ---------------------------------------------------------------------------

  Future<bool> exists() async {
    return _file.existsSync();
  }

  Future<LauncherIconConfig?> load() async {
    if (!await exists()) return null;

    final yaml = loadYaml(await _file.readAsString());
    return LauncherIconConfig.fromMap(Map<dynamic, dynamic>.from(yaml['flutter_launcher_icons'] ?? const {}));
  }

  Future<void> save(LauncherIconConfig config) async {
    final buffer = StringBuffer();

    buffer.writeln('flutter_launcher_icons:');
    buffer.writeln('  image_path: "${config.imagePath}"');
    buffer.writeln();
    buffer.writeln('  android: ${config.android}');
    buffer.writeln('  ios: ${config.ios}');
    buffer.writeln();

    buffer.writeln('  adaptive_icon_background: "${config.adaptiveBackground}"');
    buffer.writeln('  adaptive_icon_foreground: "${config.adaptiveForeground}"');

    if (config.adaptiveMonochrome != null && config.adaptiveMonochrome!.isNotEmpty) {
      buffer.writeln('  adaptive_icon_monochrome: "${config.adaptiveMonochrome}"');
    }

    buffer.writeln();
    buffer.writeln('  remove_alpha_ios: ${config.removeAlphaIos}');
    buffer.writeln();

    buffer.writeln('  web:');
    buffer.writeln('    generate: ${config.web}');
    buffer.writeln('    image_path: "${config.imagePath}"');
    buffer.writeln('    background_color: "${config.adaptiveBackground}"');
    buffer.writeln('    theme_color: "#000000"');

    await _file.writeAsString(buffer.toString());

    LoggerService.success('$fileName updated.');
  }

  Future<List<String>> validate() async {
    final issues = <String>[];
    final config = await load();

    if (config == null) {
      issues.add('$fileName not found.');
      return issues;
    }

    if (!File(config.imagePath).existsSync()) issues.add('Icon image not found: ${config.imagePath}');

    if (!File(config.adaptiveForeground).existsSync()) issues.add('Adaptive foreground not found: ${config.adaptiveForeground}');

    if (config.adaptiveMonochrome != null && config.adaptiveMonochrome!.isNotEmpty && !File(config.adaptiveMonochrome!).existsSync()) {
      issues.add('Adaptive monochrome not found: ${config.adaptiveMonochrome}');
    }

    return issues;
  }

  Future<LauncherIconConfig> configure() async {
    LoggerService.blank();

    LoggerService.info('Launcher Icons');

    final imagePath = PromptService.ask('Icon image path', defaultValue: 'assets/images/app_icon.png');

    final android = PromptService.confirm('Generate Android icons?', defaultValue: true);

    final ios = PromptService.confirm('Generate iOS icons?', defaultValue: true);

    final web = PromptService.confirm('Generate Web icons?', defaultValue: true);

    final adaptiveBackground = PromptService.ask('Adaptive background', defaultValue: '#FFFFFF');

    final adaptiveForeground = PromptService.ask('Adaptive foreground', defaultValue: imagePath);

    final adaptiveMonochrome = PromptService.ask('Adaptive monochrome (optional)', defaultValue: '');

    final removeAlphaIos = PromptService.confirm('Remove alpha for iOS?', defaultValue: true);

    return LauncherIconConfig(
      imagePath: imagePath,
      android: android,
      ios: ios,
      web: web,
      adaptiveBackground: adaptiveBackground,
      adaptiveForeground: adaptiveForeground,
      adaptiveMonochrome: adaptiveMonochrome.isEmpty ? null : adaptiveMonochrome,
      removeAlphaIos: removeAlphaIos,
    );
  }
}
