/// Provides platform identifiers and predefined platform groups used by FKIT.
class AppPlatform {
  AppPlatform._();

  /// The Android platform identifier.
  static const android = 'android';

  /// The iOS platform identifier.
  static const ios = 'ios';

  /// The web platform identifier.
  static const web = 'web';

  /// The platforms considered mobile platforms.
  static const mobile = [
    android,
    ios,
  ];

  /// All platforms supported by FKIT.
  static const all = [
    android,
    ios,
    web,
  ];
}
