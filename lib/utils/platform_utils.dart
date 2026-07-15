import '../models/build_platform.dart';
import '../models/firebase/firebase_details.dart';
import '../models/firebase/firebase_platform.dart';
import '../models/init_config.dart';

/// Provides utility methods for resolving platform-specific configuration.
class PlatformUtils {
  const PlatformUtils._();

  /// Determines whether the specified [platform] is enabled in [config].
  ///
  /// Returns `false` when the platform is not supported.
  static bool isEnabled(
    InitConfig config,
    String platform,
  ) {
    switch (platform) {
      case 'android':
        return config.android;

      case 'ios':
        return config.ios;

      case 'web':
        return config.web;

      default:
        return false;
    }
  }

  /// Resolves the build platform associated with the specified [platform].
  ///
  /// Throws an [UnsupportedError] when the platform is not supported.
  static BuildPlatform buildPlatform(
    String platform,
  ) {
    switch (platform) {
      case 'android':
        return BuildPlatform.apk;

      case 'ios':
        return BuildPlatform.ipa;

      case 'web':
        return BuildPlatform.web;

      default:
        throw UnsupportedError(
          'Unsupported platform: $platform',
        );
    }
  }

  /// Resolves the Firebase configuration for the specified [platform].
  ///
  /// Returns `null` when Firebase is not configured for the platform.
  /// Throws an [UnsupportedError] when the platform is not supported.
  static FirebasePlatform? firebasePlatform(
    FirebaseDetails firebase,
    String platform,
  ) {
    switch (platform) {
      case 'android':
        return firebase.android;

      case 'ios':
        return firebase.ios;

      case 'web':
        return firebase.web;

      default:
        throw UnsupportedError(
          'Unsupported platform: $platform',
        );
    }
  }

  /// Returns the Firebase application ID for the specified [platform].
  ///
  /// Returns `null` when Firebase is not configured for the platform.
  static String? firebaseAppId(
    FirebaseDetails firebase,
    String platform,
  ) {
    return firebasePlatform(
      firebase,
      platform,
    )?.appId;
  }

  /// Returns the Firebase options file path for the specified [platform].
  ///
  /// Returns `null` when Firebase is not configured for the platform.
  static String? firebaseOptions(
    FirebaseDetails firebase,
    String platform,
  ) {
    return firebasePlatform(
      firebase,
      platform,
    )?.options;
  }
}
