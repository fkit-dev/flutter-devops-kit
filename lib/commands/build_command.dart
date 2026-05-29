import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';

class BuildCommand extends BaseArgCommand {
  @override
  String get name => 'build';

  @override
  String get description => 'Build flutter app';

  @override
  ArgParser buildParser() {
    return ArgParser();
  }

  @override
  Future<void> execute(ArgResults results) async {
    if (results.rest.isEmpty) {
      LoggerService.error('Usage: fkit build <apk|aab|ipa|web> [flavor]');
      return;
    }

    final config = await ConfigService.load();
    final platformArg = results.rest.first;
    final flavor = results.rest.length > 1 ? results.rest[1] : config.defaultFlavor;
    final platform = switch (platformArg) {
      'apk' => BuildPlatform.apk,
      'aab' => BuildPlatform.aab,
      'ipa' => BuildPlatform.ipa,
      'web' => BuildPlatform.web,

      _ => throw Exception('Unsupported build platform'),
    };

    LoggerService.info('Platform : $platformArg');
    LoggerService.info('Flavor   : $flavor');

    final buildService = BuildService();
    await buildService.build(platform: platform, flavor: flavor);
  }
}
