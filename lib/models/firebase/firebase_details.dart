import 'firebase_platform.dart';

/// Defines Firebase configuration for all supported application platforms.
class FirebaseDetails {
  /// The Firebase configuration for Android.
  final FirebasePlatform? android;

  /// The Firebase configuration for iOS.
  final FirebasePlatform? ios;

  /// The Firebase configuration for web.
  final FirebasePlatform? web;

  /// Creates Firebase configuration for the supported platforms.
  const FirebaseDetails({this.android, this.ios, this.web});

  /// Creates Firebase platform configuration from the provided [map].
  factory FirebaseDetails.fromMap(Map<String, dynamic> map) {
    return FirebaseDetails(
        android: _platformFromMap(map['android']),
        ios: _platformFromMap(map['ios']),
        web: _platformFromMap(map['web']));
  }

  /// Converts this Firebase configuration to a map.
  Map<String, dynamic> toMap() {
    return {
      if (android != null) 'android': android!.toMap(),
      if (ios != null) 'ios': ios!.toMap(),
      if (web != null) 'web': web!.toMap()
    };
  }

  /// Returns the configured Firebase platforms as named entries.
  Iterable<FirebasePlatformEntry> entries() sync* {
    if (android != null) yield FirebasePlatformEntry('android', android!);
    if (ios != null) yield FirebasePlatformEntry('ios', ios!);
    if (web != null) yield FirebasePlatformEntry('web', web!);
  }

  static FirebasePlatform? _platformFromMap(dynamic value) {
    if (value is! Map) return null;
    return FirebasePlatform.fromMap(Map<String, dynamic>.from(value));
  }
}

/// Associates a platform name with its Firebase configuration.
class FirebasePlatformEntry {
  /// The name of the platform.
  final String name;

  /// The Firebase configuration associated with the platform.
  final FirebasePlatform platform;

  /// Creates a Firebase platform entry.
  const FirebasePlatformEntry(this.name, this.platform);
}
