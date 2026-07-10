import '../models/build_platform.dart';
import '../models/firebase_platform.dart';
import '../models/flavor_details.dart';
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
  /// Uses the platform configuration defined by the provided [flavor].
  /// Throws an [UnsupportedError] when the platform is not supported.
  static FirebasePlatform firebasePlatform(
    FlavorDetails flavor,
    String platform,
  ) {
    switch (platform) {
      case 'android':
        return flavor.firebase.android;

      case 'ios':
        return flavor.firebase.ios;

      case 'web':
        return flavor.firebase.web;

      default:
        throw UnsupportedError(
          'Unsupported platform: $platform',
        );
    }
  }

  /// Returns the Firebase application ID for the specified [platform].
  static String firebaseAppId(
    FlavorDetails flavor,
    String platform,
  ) {
    return firebasePlatform(
      flavor,
      platform,
    ).appId;
  }

  /// Returns the Firebase options file path for the specified [platform].
  static String firebaseOptions(
    FlavorDetails flavor,
    String platform,
  ) {
    return firebasePlatform(
      flavor,
      platform,
    ).options;
  }
}
