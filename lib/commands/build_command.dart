import '../core/command.dart';
import '../models/build_platform.dart';
import '../services/build_service.dart';

class BuildCommand extends Command {
  @override
  String get name => 'build';

  @override
  String get description => 'Build flutter app';

  @override
  Future<void> run(List<String> args) async {
    if (args.length < 2) {
      throw Exception('❌ Usage: fkit build <apk|aab|ipa|web> <flavor>');
    }

    final platformArg = args[0];

    final flavor = args[1];

    final platform = switch (platformArg) {
      'apk' => BuildPlatform.apk,
      'aab' => BuildPlatform.aab,
      'ipa' => BuildPlatform.ipa,
      'web' => BuildPlatform.web,
      _ => throw Exception('❌ Unsupported build platform'),
    };

    final buildService = BuildService();

    await buildService.build(platform: platform, flavor: flavor);
  }
}
