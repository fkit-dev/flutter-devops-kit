/// Defines the platforms enabled in an FKIT configuration.
class PlatformConfig {
  /// Whether Android platform support is enabled.
  final bool android;

  /// Whether iOS platform support is enabled.
  final bool ios;

  /// Whether web platform support is enabled.
  final bool web;

  /// Creates a platform configuration.
  PlatformConfig({
    required this.android,
    required this.ios,
    required this.web,
  });

  /// Creates a platform configuration from the provided [map].
  factory PlatformConfig.fromMap(Map<dynamic, dynamic> map) {
    return PlatformConfig(
      android: map['android'] ?? false,
      ios: map['ios'] ?? false,
      web: map['web'] ?? false,
    );
  }
}
