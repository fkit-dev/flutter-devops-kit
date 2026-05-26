import '../core/command.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';
import '../services/config_service.dart';
import '../services/firebase_service.dart';

class FirebaseCommand extends Command {
  @override
  String get name => 'firebase';

  @override
  String get description => 'Build and upload to Firebase';

  @override
  Future<void> run(List<String> args) async {
    if (args.isEmpty) {
      throw Exception('❌ Usage: fkit firebase <flavor> [--notes=\"message\"]');
    }

    final flavor = args.first;

    String notes = 'Automated build upload via FKIT';

    final notesArg = args.where((e) => e.startsWith('--notes='));

    if (notesArg.isNotEmpty) {
      notes = notesArg.first.replaceFirst('--notes=', '');
    }

    final config = await ConfigService.load();

    final flavorConfig = config.flavors[flavor];

    if (flavorConfig == null) {
      throw Exception('❌ Flavor "$flavor" not found');
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
