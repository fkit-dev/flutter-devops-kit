import '../../models/init_config.dart';
import '../../wizard/models/flavor_setup.dart';
import '../../wizard/models/platform_setup.dart';

/// Maps FKIT models into wizard setup models.
class ConfigMapper {
  /// Creates a [FlavorSetup] from the provided [config].
  static FlavorSetup toFlavorSetup(InitConfig config) {
    return FlavorSetup(
      enabled: config.flavoringEnabled,
      defaultFlavor: config.defaultFlavor,
      flavors: config.flavors,
    );
  }

  /// Creates a [PlatformSetup] from the provided [config].
  static PlatformSetup toPlatformSetup(InitConfig config) {
    return PlatformSetup(
      android: config.android,
      ios: config.ios,
      web: config.web,
    );
  }
}
