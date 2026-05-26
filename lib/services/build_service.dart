import '../models/build_mode.dart';
import '../models/build_platform.dart';
import '../models/build_result.dart';
import '../services/config_service.dart';
import '../services/flutter_service.dart';
import '../utils/command_executor.dart';
import '../validators/project_validator.dart';
import 'logger_service.dart';

class BuildService {
  Future<void> run({required String flavor, BuildMode mode = BuildMode.debug}) async {
    final config = await ConfigService.load();
    ProjectValidator.validate(config);

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) {
      throw Exception('❌ Flavor "$flavor" not found');
    }

    final flutterService = FlutterService(config);

    final command = flutterService.flutterCommand;

    final arguments = <String>[...command.skip(1), 'run', '--dart-define-from-file=${flavorConfig.env}'];

    if (mode == BuildMode.profile) {
      arguments.add('--profile');
    }

    if (mode == BuildMode.release) {
      arguments.add('--release');
    }

    LoggerService.section('Running flavor: $flavor');
    await CommandExecutor.run(command.first, arguments);
  }

  Future<BuildResult> build({required BuildPlatform platform, required String flavor}) async {
    final config = await ConfigService.load();
    ProjectValidator.validate(config);

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) {
      throw Exception('❌ Flavor "$flavor" not found');
    }

    final flutterService = FlutterService(config);

    final command = flutterService.flutterCommand;

    final buildType = switch (platform) {
      BuildPlatform.apk => 'apk',
      BuildPlatform.aab => 'appbundle',
      BuildPlatform.ipa => 'ipa',
      BuildPlatform.web => 'web',
    };

    final arguments = <String>[...command.skip(1), 'build', buildType, '--release', '--dart-define-from-file=${flavorConfig.env}'];

    if (platform != BuildPlatform.web) {
      arguments.add('--obfuscate');

      arguments.add('--split-debug-info=${config.debugInfo}');
    }

    LoggerService.section('Building $buildType for flavor: $flavor');

    await CommandExecutor.run(command.first, arguments);

    final artifactPath = switch (platform) {
      BuildPlatform.apk => 'build/app/outputs/flutter-apk/app-release.apk',

      BuildPlatform.aab => 'build/app/outputs/bundle/release/app-release.aab',

      BuildPlatform.ipa => 'build/ios/ipa',

      BuildPlatform.web => 'build/web',
    };

    return BuildResult(artifactPath: artifactPath);
  }
}
