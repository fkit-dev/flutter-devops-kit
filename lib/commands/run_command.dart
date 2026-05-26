import '../core/command.dart';
import '../models/build_mode.dart';
import '../services/build_service.dart';

class RunCommand extends Command {
  @override
  String get name => 'run';

  @override
  String get description => 'Run flutter app';

  @override
  Future<void> run(List<String> args) async {
    if (args.isEmpty) {
      throw Exception('❌ Please provide flavor');
    }

    final flavor = args.first;

    final profile = args.contains('--profile');

    final release = args.contains('--release');

    BuildMode mode = BuildMode.debug;

    if (profile) {
      mode = BuildMode.profile;
    }

    if (release) {
      mode = BuildMode.release;
    }

    final buildService = BuildService();

    await buildService.run(flavor: flavor, mode: mode);
  }
}
