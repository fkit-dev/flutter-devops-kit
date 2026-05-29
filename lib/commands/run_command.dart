import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../models/build_mode.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';
import '../services/logger_service.dart';

class RunCommand extends BaseArgCommand {
  @override
  String get name => 'run';

  @override
  String get description => 'Run flutter app';

  @override
  ArgParser buildParser() {
    return ArgParser()
      ..addFlag('profile', abbr: 'p', negatable: false)
      ..addFlag('release', abbr: 'r', negatable: false)
      ..addOption('platform', abbr: 't', defaultsTo: 'android', allowed: ['android', 'ios', 'web'], help: 'Target platform');
  }

  @override
  Future<void> execute(ArgResults results) async {
    final platform = switch (results['platform'] as String) {
      'android' => BuildPlatform.apk,
      'ios' => BuildPlatform.ipa,
      'web' => BuildPlatform.web,
      _ => BuildPlatform.apk,
    };

    if (results.rest.isEmpty) {
      LoggerService.error('Please provide flavor');

      return;
    }

    final flavor = results.rest.first;

    BuildMode mode = BuildMode.debug;

    if (results['profile']) {
      mode = BuildMode.profile;
    }

    if (results['release']) {
      mode = BuildMode.release;
    }

    final buildService = BuildService();

    await buildService.run(platform: platform, flavor: flavor, mode: mode);
  }
}
