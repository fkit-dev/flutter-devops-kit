import '../models/build_platform.dart';
import '../models/firebase_platform.dart';
import '../models/flavor_details.dart';
import '../models/init_config.dart';

class PlatformUtils {
  const PlatformUtils._();

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

  static String firebaseAppId(
    FlavorDetails flavor,
    String platform,
  ) {
    return firebasePlatform(
      flavor,
      platform,
    ).appId;
  }

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
