/// Defines the application build platforms supported by FKIT.
enum BuildPlatform {
  /// Builds an Android application package (APK).
  apk,

  /// Builds an Android App Bundle (AAB).
  aab,

  /// Builds an iOS application archive (IPA).
  ipa,

  /// Builds a web application.
  web;

  /// Creates a build platform from the provided [value].
  ///
  /// Throws an [ArgumentError] when the value does not represent a supported
  /// build platform.
  static BuildPlatform fromString(String value) {
    return switch (value.toLowerCase()) {
      'apk' => BuildPlatform.apk,
      'aab' => BuildPlatform.aab,
      'ipa' => BuildPlatform.ipa,
      'web' => BuildPlatform.web,
      _ => throw ArgumentError(
          'Unsupported build platform: $value',
        ),
    };
  }
}
