/// Defines the platforms enabled for an FKIT project.
class PlatformSetup {
  /// Whether Android platform support is enabled.
  final bool android;

  /// Whether iOS platform support is enabled.
  final bool ios;

  /// Whether web platform support is enabled.
  final bool web;

  /// Creates a platform configuration.
  const PlatformSetup({
    required this.android,
    required this.ios,
    required this.web,
  });
}
