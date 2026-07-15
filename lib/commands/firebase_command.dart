import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../core/command_category.dart';
import '../services/build_service.dart';
import '../services/config/config_service.dart';
import '../services/firebase_service.dart';
import '../services/logger_service.dart';
import '../utils/app_platform.dart';
import '../utils/platform_utils.dart';

/// Manages Firebase operations for FKIT projects.
///
/// Supports Firebase-related workflows such as application distribution.
class FirebaseCommand extends BaseArgCommand {
  @override
  String get name => 'firebase';

  @override
  String get description => 'Build and upload to Firebase App Distribution';

  @override
  CommandCategory get category => CommandCategory.distribution;

  @override
  String get usage => 'fkit firebase [target] [-p android|ios] '
      '[-n "Release Notes"] [-g testers]';

  @override
  List<String> get examples => const [
        'fkit firebase',
        'fkit firebase development',
        'fkit firebase production',
        'fkit firebase production -p ios',
        'fkit firebase production -n "Internal testing"',
        'fkit firebase production -g qa',
        'fkit firebase production -g qa -n "Internal testing"',
      ];

  @override
  bool get requiresConfig => true;

  @override
  bool get requiresFlutterProject => true;

  @override
  ArgParser buildParser() {
    return ArgParser()
      ..addOption(
        'platform',
        abbr: 'p',
        allowed: AppPlatform.mobile,
        defaultsTo: AppPlatform.android,
        help: 'Target platform',
      )
      ..addOption(
        'notes',
        abbr: 'n',
        help: 'Release notes',
      )
      ..addOption(
        'group',
        abbr: 'g',
        help: 'Firebase tester group',
      );
  }

  @override
  Future<void> execute(ArgResults results) async {
    final config = await ConfigService.load();

    if (!config.firebase.enabled) {
      LoggerService.error(
        'Firebase is disabled in fkit.yaml.',
      );
      return;
    }

    final target =
        results.rest.isNotEmpty ? results.rest.first : config.defaultFlavor;

    final platform = results['platform'] as String;

    final notes =
        results['notes'] as String? ?? 'Automated build upload via FKIT';

    final testerGroup =
        results['group'] as String? ?? config.firebase.testerGroup;

    if (!config.flavors.contains(target)) {
      LoggerService.error(
        'Target "$target" is not configured.',
      );
      return;
    }

    if (!PlatformUtils.isEnabled(config, platform)) {
      LoggerService.error(
        '$platform is disabled in fkit.yaml.',
      );
      return;
    }

    final firebase = config.firebase.configurationFor(target);

    if (firebase == null) {
      LoggerService.error(
        'Firebase configuration not found for target "$target".',
      );
      return;
    }

    final firebasePlatform = PlatformUtils.firebasePlatform(
      firebase,
      platform,
    );

    if (firebasePlatform == null) {
      LoggerService.error(
        '$platform Firebase configuration is not available '
        'for target "$target".',
      );
      return;
    }

    if (firebasePlatform.appId.isEmpty) {
      LoggerService.error(
        '$platform Firebase App ID is not configured '
        'for target "$target".',
      );
      return;
    }

    final buildResult = await BuildService().build(
      platform: PlatformUtils.buildPlatform(platform),
      flavor: target,
    );

    await FirebaseService().upload(
      appId: firebasePlatform.appId,
      artifactPath: buildResult.artifactPath,
      testerGroup: testerGroup,
      notes: notes,
    );

    LoggerService.blank();
    LoggerService.success(
      'Firebase upload completed successfully.',
    );
    LoggerService.blank();
  }
}
