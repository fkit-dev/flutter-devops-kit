import 'package:path/path.dart' as p;

import 'section_maintainer.dart';

/// Maintains the generated App widget.
class AppMaintainer {
  /// Creates an app maintainer.
  const AppMaintainer();

  /// Enables Flutter localization support inside the generated App.
  Future<void> enableLocalization({
    required String appFilePath,
    required String outputDir,
    required String outputFile,
  }) async {
    const maintainer = SectionMaintainer();
    final importPath = p
        .relative(
          p.join(outputDir, outputFile),
          from: p.dirname(appFilePath),
        )
        .replaceAll(r'\', '/');

    await maintainer.appendToSection(
      filePath: appFilePath,
      marker: 'imports',
      content: "import '$importPath';",
    );

    await maintainer.appendToSection(
      filePath: appFilePath,
      marker: 'material_app',
      content: '''
localizationsDelegates: AppLocalizations.localizationsDelegates,
supportedLocales: AppLocalizations.supportedLocales,
''',
    );
  }
}
