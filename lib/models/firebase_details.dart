import 'firebase_platform.dart';

class FirebaseDetails {
  final FirebasePlatform android;
  final FirebasePlatform ios;
  final FirebasePlatform web;

  const FirebaseDetails({
    required this.android,
    required this.ios,
    required this.web,
  });

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

  Map<String, dynamic> toMap() {
    return {
      'android': android.toMap(),
      'ios': ios.toMap(),
      'web': web.toMap(),
    };
  }

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

class FirebasePlatformEntry {
  final String name;
  final FirebasePlatform platform;

  const FirebasePlatformEntry(
    this.name,
    this.platform,
  );
}
