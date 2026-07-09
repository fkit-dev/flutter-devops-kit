import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../models/build_mode.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';
import '../services/config_service.dart';

class RunCommand extends BaseArgCommand {
  @override
  String get name => 'run';

  @override
  String get description => 'Run Flutter application';

  @override
  CommandCategory get category => CommandCategory.run;

  @override
  String get usage => 'fkit run [flavor] [-p] [-r] [-t android|ios|web]';

  @override
  List<String> get examples => const [
        'fkit run',
        'fkit run development',
        'fkit run production -r',
        'fkit run production -p',
        'fkit run -t web',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  ArgParser buildParser() {
    return ArgParser()
      ..addFlag(
        'profile',
        abbr: 'p',
        negatable: false,
        help: 'Run in profile mode',
      )
      ..addFlag(
        'release',
        abbr: 'r',
        negatable: false,
        help: 'Run in release mode',
      )
      ..addOption(
        'platform',
        abbr: 't',
        defaultsTo: 'android',
        allowed: const [
          'android',
          'ios',
          'web',
        ],
        help: 'Target platform',
      );
  }

  @override
  Future<void> execute(
    ArgResults results,
  ) async {
    final config = await ConfigService.load();

    final flavor =
        results.rest.isEmpty ? config.defaultFlavor : results.rest.first;

    final platform = switch (results['platform'] as String) {
      'android' => BuildPlatform.apk,
      'ios' => BuildPlatform.ipa,
      'web' => BuildPlatform.web,
      _ => BuildPlatform.apk,
    };

    BuildMode mode = BuildMode.debug;

    if (results['profile']) {
      mode = BuildMode.profile;
    }

    if (results['release']) {
      mode = BuildMode.release;
    }

    await BuildService().run(
      platform: platform,
      flavor: flavor,
      mode: mode,
    );
  }
}
