import 'dart:io';

import '../generators/localization/arb_generator.dart';
import '../generators/localization/l10n_yaml_generator.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../validators/localization_validator.dart';
import 'pubspec_service.dart';

class LocalizationService {
  Future<void> setup() async {
    await generate();
  }

  Future<void> generate() async {
    LoggerService.section('Generate Localization');

    _ensureFlutterProject();

    final config = await ConfigService.load();

    final pubspec = PubspecService();
    await pubspec.ensureLocalization();

    await L10nYamlGenerator.generate(config);
    await ArbGenerator.generate(config);
    await FlutterService(config).genL10n();

    LocalizationValidator.validate(config);
    LoggerService.success('Localization generated successfully.');
  }

  Future<void> doctor() async {
    LoggerService.section('Localization Doctor');
    _ensureFlutterProject();

    final config = await ConfigService.load();
    LocalizationValidator.validate(config);
    LoggerService.success('Localization configuration looks good.');
  }

  void _ensureFlutterProject() {
    if (!File('pubspec.yaml').existsSync()) {
      throw Exception('Current directory is not a Flutter project.');
    }
  }
}
