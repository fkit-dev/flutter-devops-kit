import 'package:args/args.dart';

import '../core/base_arg_command.dart';
import '../models/build_mode.dart';
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
      ..addFlag('release', abbr: 'r', negatable: false);
  }

  @override
  Future<void> execute(ArgResults results) async {
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

    await buildService.run(flavor: flavor, mode: mode);
  }
}
