import 'dart:io';

import '../generators/localization/arb_generator.dart';
import '../generators/localization/l10n_yaml_generator.dart';
import '../generators/maintainers/app_maintainer.dart';
import '../models/init_config.dart';
import '../services/flutter_service.dart';
import '../services/logger_service.dart';
import '../validators/localization_validator.dart';
import 'config/config_service.dart';
import 'pubspec_service.dart';

/// Manages localization setup, generation, and validation for Flutter projects.
class LocalizationService {
  /// Sets up localization support for the current Flutter project.
  ///
  /// Delegates to [generate] to configure and generate localization files.
  Future<void> setup({
    bool overwrite = false,
    bool runFlutterCommands = true,
    String? appFilePath,
  }) async {
    await generate(
      overwrite: overwrite,
      runFlutterCommands: runFlutterCommands,
      appFilePath: appFilePath,
    );
  }

  /// Configures and generates localization resources for the current project.
  ///
  /// Ensures the required dependencies and Flutter configuration are present,
  /// generates localization files, runs Flutter localization generation, and
  /// validates the resulting configuration.
  Future<void> generate({
    InitConfig? config,
    bool maintainApp = true,
    String? appFilePath,
    bool runFlutterCommands = true,
    bool syncDependencies = true,
    bool overwrite = false,
  }) async {
    LoggerService.section('Generate Localization');

    _ensureFlutterProject();

    final resolvedConfig = config ?? await ConfigService.load();

    final pubspec = PubspecService(runPubGet: runFlutterCommands);
    await pubspec.ensureLocalization(syncDependencies: syncDependencies);

    await L10nYamlGenerator.generate(resolvedConfig);
    await ArbGenerator.generate(resolvedConfig);
    if (runFlutterCommands) {
      await FlutterService(resolvedConfig).genL10n();
    }
    if (maintainApp) {
      final targetAppFile = appFilePath ?? 'lib/app/app.dart';
      if (!File(targetAppFile).existsSync()) {
        throw Exception(
          'Cannot enable localization: App file not found at $targetAppFile.',
        );
      }
      await const AppMaintainer().enableLocalization(
        appFilePath: targetAppFile,
        outputDir: resolvedConfig.localization.outputDir,
        outputFile: resolvedConfig.localization.outputFile,
      );
    }
    LocalizationValidator.validate(resolvedConfig);
    LoggerService.success('Localization generated successfully.');
  }

  /// Validates the localization configuration of the current Flutter project.
  ///
  /// Reports an error when the localization configuration is invalid.
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
