import '../models/project_config.dart';

class FlavorValidator {
  static void validate(ProjectConfig config, String flavor) {
    if (!config.flavors.containsKey(flavor)) {
      throw Exception('❌ Flavor "$flavor" not configured');
    }
  }
}
