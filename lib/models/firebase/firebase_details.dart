import 'firebase_platform.dart';

/// Defines Firebase configuration for all supported application platforms.
class FirebaseDetails {
  /// The Firebase configuration for Android.
  final FirebasePlatform android;

  /// The Firebase configuration for iOS.
  final FirebasePlatform ios;

  /// The Firebase configuration for web.
  final FirebasePlatform web;

  /// Creates Firebase configuration for the supported platforms.
  const FirebaseDetails({
    required this.android,
    required this.ios,
    required this.web,
  });

  /// Creates Firebase platform configuration from the provided [map].
  factory FirebaseDetails.fromMap(
    Map<String, dynamic> map,
  ) {
    return FirebaseDetails(
      android: FirebasePlatform.fromMap(
        Map<String, dynamic>.from(
          map['android'] ?? {},
        ),
      ),
      ios: FirebasePlatform.fromMap(
        Map<String, dynamic>.from(
          map['ios'] ?? {},
        ),
      ),
      web: FirebasePlatform.fromMap(
        Map<String, dynamic>.from(
          map['web'] ?? {},
        ),
      ),
    );
  }

  /// Converts this Firebase configuration to a map.
  Map<String, dynamic> toMap() {
    return {
      'android': android.toMap(),
      'ios': ios.toMap(),
      'web': web.toMap(),
    };
  }

  /// Returns the Firebase configurations as named platform entries.
  Iterable<FirebasePlatformEntry> entries() sync* {
    yield FirebasePlatformEntry(
      'android',
      android,
    );

    yield FirebasePlatformEntry(
      'ios',
      ios,
    );

    yield FirebasePlatformEntry(
      'web',
      web,
    );
  }
}

/// Associates a platform name with its Firebase configuration.
class FirebasePlatformEntry {
  /// The name of the platform.
  final String name;

  /// The Firebase configuration associated with the platform.
  final FirebasePlatform platform;

  /// Creates a Firebase platform entry.
  const FirebasePlatformEntry(
    this.name,
    this.platform,
  );
}
