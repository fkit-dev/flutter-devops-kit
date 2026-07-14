import '../models/build_mode.dart';
import '../models/build_platform.dart';
import '../models/build_result.dart';
import '../models/init_config.dart';
import '../validators/init_validator.dart';
import 'artifact_service.dart';
import 'config_service.dart';
import 'flutter_service.dart';
import 'logger_service.dart';

/// Manages application build and run operations for FKIT projects.
class BuildService {
  /// Runs the application using the provided configuration and options.
  Future<void> run({
    required BuildPlatform platform,
    required String flavor,
    BuildMode mode = BuildMode.debug,
  }) async {
    final config = await ConfigService.load();

    InitValidator.validate(config);

    _validateTarget(config, flavor);

    final arguments = <String>['run'];

    if (config.flavoringEnabled && platform != BuildPlatform.web) {
      arguments.addAll([
        '--flavor',
        flavor,
      ]);
    }

    _addEnvironmentArguments(
      arguments: arguments,
      config: config,
      target: flavor,
    );

    switch (mode) {
      case BuildMode.debug:
        break;

      case BuildMode.profile:
        arguments.add('--profile');
        break;

      case BuildMode.release:
        arguments.add('--release');
        break;
    }

    LoggerService.section('Running $flavor');

    await FlutterService(config).runFlutter(arguments);
  }

  /// Builds the application and returns the generated build result.
  Future<BuildResult> build({
    required BuildPlatform platform,
    required String flavor,
  }) async {
    final config = await ConfigService.load();

    InitValidator.validate(config);

    _validateTarget(config, flavor);

    final buildType = switch (platform) {
      BuildPlatform.apk => 'apk',
      BuildPlatform.aab => 'appbundle',
      BuildPlatform.ipa => 'ipa',
      BuildPlatform.web => 'web',
    };

    final arguments = <String>[
      'build',
      buildType,
    ];

    if (config.flavoringEnabled && platform != BuildPlatform.web) {
      arguments.addAll([
        '--flavor',
        flavor,
      ]);
    }

    arguments.add('--release');

    _addEnvironmentArguments(
      arguments: arguments,
      config: config,
      target: flavor,
    );

    if (platform != BuildPlatform.web && config.obfuscate) {
      arguments.addAll([
        '--obfuscate',
        '--split-debug-info=${config.debugInfo}',
      ]);
    }

    LoggerService.section(
      'Building $buildType ($flavor)',
    );

    await FlutterService(config).runFlutter(arguments);

    final artifactPath = await ArtifactService.resolve(
      platform: platform,
      flavor: flavor,
    );

    LoggerService.success('Artifact generated.');

    return BuildResult(
      artifactPath: artifactPath,
    );
  }

  void _validateTarget(
    InitConfig config,
    String target,
  ) {
    if (!config.flavors.contains(target)) {
      throw Exception(
        'Target "$target" not configured.',
      );
    }
  }

  void _addEnvironmentArguments({
    required List<String> arguments,
    required InitConfig config,
    required String target,
  }) {
    if (!config.environment.enabled) {
      return;
    }

    final environment = config.environment.configurationFor(target);

    if (environment == null) {
      throw Exception(
        'Environment configuration not found for target "$target".',
      );
    }

    if (environment.file.isEmpty) {
      throw Exception(
        'Environment file not configured for target "$target".',
      );
    }

    arguments.add(
      '--dart-define-from-file=${environment.file}',
    );
  }
}
