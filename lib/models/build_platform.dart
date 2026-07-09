enum BuildPlatform {
  apk,
  aab,
  ipa,
  web;

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
