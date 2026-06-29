import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../services/build_service.dart';
import '../services/config_service.dart';
import '../services/firebase_service.dart';
import '../services/logger_service.dart';
import '../utils/app_platform.dart';
import '../utils/platform_utils.dart';

class FirebaseCommand extends BaseArgCommand {
  @override
  String get name => 'firebase';

  @override
  String get description => 'Build and upload to Firebase App Distribution';

  @override
  CommandCategory get category => CommandCategory.distribution;

  @override
  String get usage => 'fkit firebase <flavor> [-p android|ios]';

  @override
  List<String> get examples => const [
        'fkit firebase development',
        'fkit firebase production',
        'fkit firebase production -p ios',
        'fkit firebase production -n "Internal testing"',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  ArgParser buildParser() {
    return ArgParser()
      ..addOption('platform', abbr: 'p', allowed: AppPlatform.mobile, defaultsTo: AppPlatform.android, help: 'Target platform')
      ..addOption('notes', abbr: 'n', help: 'Release notes');
  }

  @override
  Future<void> execute(
    ArgResults results,
  ) async {
    if (results.rest.isEmpty) {
      LoggerService.error('Usage: $usage');
      return;
    }

    final flavor = results.rest.first;

    final platform = results['platform'] as String;

    final notes = results['notes'] as String? ?? 'Automated build upload via FKIT';

    final config = await ConfigService.load();

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) {
      LoggerService.error('Flavor "$flavor" not found.');
      return;
    }

    if (!PlatformUtils.isEnabled(
      config,
      platform,
    )) {
      LoggerService.error(
        '$platform is disabled in fkit.yaml.',
      );
      return;
    }

    final appId = PlatformUtils.firebaseAppId(
      flavorConfig,
      platform,
    );

    if (appId.isEmpty) {
      LoggerService.error(
        '$platform Firebase App ID is not configured.',
      );
      return;
    }

    final buildResult = await BuildService().build(
      platform: PlatformUtils.buildPlatform(
        platform,
      ),
      flavor: flavor,
    );

    await FirebaseService().upload(
      appId: appId,
      artifactPath: buildResult.artifactPath,
      testerGroup: config.testerGroup,
      notes: notes,
    );

    LoggerService.blank();

    LoggerService.success(
      'Firebase upload completed successfully.',
    );

    LoggerService.blank();
  }
}
