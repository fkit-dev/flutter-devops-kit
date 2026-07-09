import 'package:flutter_devops_kit/models/init_config.dart';

class FlavorValidator {
  static void validate(InitConfig config, String flavor) {
    if (!config.flavors.containsKey(flavor)) {
      throw Exception('❌ Flavor "$flavor" not configured');
    }
  }
}
