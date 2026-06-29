import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';
import '../services/config_service.dart';
import '../services/logger_service.dart';

class BuildCommand extends BaseArgCommand {
  @override
  String get name => 'build';

  @override
  String get description => 'Build Flutter application';

  @override
  CommandCategory get category => CommandCategory.build;

  @override
  String get usage => 'fkit build <apk|aab|ipa|web> [flavor]';

  @override
  List<String> get examples => const [
        'fkit build apk',
        'fkit build apk development',
        'fkit build aab production',
        'fkit build ipa production',
        'fkit build web',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  ArgParser buildParser() => ArgParser();

  @override
  Future<void> execute(ArgResults results) async {
    if (results.rest.isEmpty) {
      LoggerService.error('Usage: $usage');
      return;
    }

    final config = await ConfigService.load();

    final platformArg = results.rest.first;

    final flavor = results.rest.length > 1 ? results.rest[1] : config.defaultFlavor;

    final platform = BuildPlatform.fromString(platformArg);

    LoggerService.info('Platform : $platformArg');

    LoggerService.info('Flavor   : $flavor');

    await BuildService().build(platform: platform, flavor: flavor);
  }
}
