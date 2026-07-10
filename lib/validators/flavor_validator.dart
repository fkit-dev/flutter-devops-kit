import 'package:flutter_devops_kit/models/init_config.dart';

/// Validates flavor configuration for an FKIT project.
class FlavorValidator {
  /// Validates the specified [flavor] against the provided project [config].
  ///
  /// Throws an exception when the flavor is invalid or not configured.
  static void validate(InitConfig config, String flavor) {
    if (!config.flavors.containsKey(flavor)) {
      throw Exception('❌ Flavor "$flavor" not configured');
    }
  }
}
