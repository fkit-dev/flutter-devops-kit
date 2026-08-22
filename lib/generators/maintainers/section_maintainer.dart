import 'dart:io';

/// Maintains marker-based sections inside source files.
///
/// Sections are identified using paired markers:
///
/// ```dart
/// // <fkit:imports>
/// // </fkit:imports>
/// ```
///
/// Content can be appended safely without duplicating existing entries.
class SectionMaintainer {
  /// Creates a section maintainer.
  const SectionMaintainer();

  /// Appends [content] inside the section identified by [marker].
  ///
  /// If the same content already exists inside the section, no changes are
  /// made.
  Future<void> appendToSection({
    required String filePath,
    required String marker,
    required String content,
  }) async {
    final file = File(filePath);

    if (!file.existsSync()) {
      throw Exception('File not found: $filePath');
    }

    final source = await file.readAsString();

    final start = '<fkit:$marker>';
    final end = '</fkit:$marker>';

    final startIndex = source.indexOf(start);
    final endIndex = source.indexOf(end);

    if (startIndex == -1 || endIndex == -1 || endIndex <= startIndex) {
      throw Exception(
        'Marker <$marker> not found in $filePath.',
      );
    }

    final sectionStart = startIndex + start.length;

    final before = source.substring(0, sectionStart);
    final section = source.substring(sectionStart, endIndex);
    final after = source.substring(endIndex);

    final trimmedContent = content.trim();

    if (section.contains(trimmedContent)) {
      return;
    }

    final updatedSection = [
      section.trimRight(),
      if (section.trim().isNotEmpty) '',
      trimmedContent,
      '',
    ].join('\n');

    final updatedSource = '$before\n$updatedSection$after';

    await file.writeAsString(updatedSource);
  }
}
