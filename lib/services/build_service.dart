import '../models/build_mode.dart';
import '../models/build_platform.dart';
import '../models/build_result.dart';
import '../validators/init_validator.dart';
import 'artifact_service.dart';
import 'config_service.dart';
import 'flutter_service.dart';
import 'logger_service.dart';

class BuildService {
  Future<void> run({
    required BuildPlatform platform,
    required String flavor,
    BuildMode mode = BuildMode.debug,
  }) async {
    final config = await ConfigService.load();

    InitValidator.validate(config);

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) throw Exception('Flavor "$flavor" not found.');

    final arguments = <String>['run'];

    if (config.flavoringEnabled && platform != BuildPlatform.web) arguments.addAll(['--flavor', flavor]);

    arguments.add('--dart-define-from-file=${flavorConfig.env}');

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

  Future<BuildResult> build({required BuildPlatform platform, required String flavor}) async {
    final config = await ConfigService.load();

    InitValidator.validate(config);

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) throw Exception('Flavor "$flavor" not found.');

    final buildType = switch (platform) {
      BuildPlatform.apk => 'apk',
      BuildPlatform.aab => 'appbundle',
      BuildPlatform.ipa => 'ipa',
      BuildPlatform.web => 'web'
    };

    final arguments = <String>['build', buildType];

    if (config.flavoringEnabled && platform != BuildPlatform.web) {
      arguments.addAll(['--flavor', flavor]);
    }

    arguments.addAll(['--release', '--dart-define-from-file=${flavorConfig.env}']);

    if (platform != BuildPlatform.web) {
      arguments.addAll(['--obfuscate', '--split-debug-info=${config.debugInfo}']);
    }

    LoggerService.section('Building $buildType ($flavor)');

    await FlutterService(config).runFlutter(arguments);

    final artifactPath = await ArtifactService.resolve(platform: platform, flavor: flavor);

    LoggerService.success('Artifact generated.');

    return BuildResult(artifactPath: artifactPath);
  }
}
