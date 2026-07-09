import 'dart:io';

import '../models/build_platform.dart';

class ArtifactService {
  static Future<String> resolve(
      {required BuildPlatform platform, required String flavor}) async {
    final directory = switch (platform) {
      BuildPlatform.apk => Directory('build/app/outputs/flutter-apk'),
      BuildPlatform.aab => Directory('build/app/outputs/bundle'),
      BuildPlatform.ipa => Directory('build/ios/ipa'),
      BuildPlatform.web => Directory('build/web'),
    };

    if (!directory.existsSync()) {
      throw Exception(
        '❌ Build output directory not found: '
        '${directory.path}',
      );
    }

    final extension = switch (platform) {
      BuildPlatform.apk => '.apk',
      BuildPlatform.aab => '.aab',
      BuildPlatform.ipa => '.ipa',
      BuildPlatform.web => '',
    };

    if (platform == BuildPlatform.web) {
      return directory.path;
    }

    final files = directory
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith(extension))
        .toList();

    if (files.isEmpty) {
      throw Exception('❌ No build artifact found');
    }

    files.sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));

    return files.first.path;
  }
}
