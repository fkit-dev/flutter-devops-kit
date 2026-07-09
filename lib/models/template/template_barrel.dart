class TemplateBarrel {
  const TemplateBarrel({
    required this.enabled,
    required this.file,
    required this.exports,
    required this.ignore,
  });

  /// Whether barrel synchronization is enabled.
  final bool enabled;

  /// Output barrel file.
  final String file;

  /// Folders to scan.
  final List<String> exports;

  /// Glob patterns to ignore.
  final List<String> ignore;

  factory TemplateBarrel.fromMap(Map<dynamic, dynamic> map) {
    return TemplateBarrel(
      enabled: map['enabled'] ?? true,
      file: map['file']?.toString() ?? 'xcore.dart',
      exports: List<String>.from(map['exports'] ?? const []),
      ignore: List<String>.from(map['ignore'] ?? const []),
    );
  }
}
