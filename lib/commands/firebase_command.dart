import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';
import '../services/config_service.dart';
import '../services/firebase_service.dart';
import '../services/logger_service.dart';

class FirebaseCommand extends BaseArgCommand {
  @override
  String get name => 'firebase';

  @override
  String get description => 'Build and upload to Firebase';

  @override
  ArgParser buildParser() {
    return ArgParser()..addOption('notes', abbr: 'n', help: 'Release notes');
  }

  @override
  Future<void> execute(ArgResults results) async {
    if (results.rest.isEmpty) {
      LoggerService.error('Usage: fkit firebase <flavor>');

      return;
    }

    final flavor = results.rest.first;

    final notes = results['notes'] ?? 'Automated build upload via FKIT';

    final config = await ConfigService.load();

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) {
      LoggerService.error('Flavor "$flavor" not found');

      return;
    }

    final buildService = BuildService();

    final buildResult = await buildService.build(platform: BuildPlatform.apk, flavor: flavor);

    final firebaseService = FirebaseService();

    await firebaseService.upload(
      appId: flavorConfig.firebase.appDistributionId,

      artifactPath: buildResult.artifactPath,

      testerGroup: config.testerGroup,

      notes: notes,
    );
  }
}
