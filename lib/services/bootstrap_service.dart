import '../models/init_config.dart';
import 'extension_service.dart';
import 'localization_service.dart';

class BootstrapService {
  Future<void> setup(InitConfig config) async {
    if (config.localizationEnabled) await LocalizationService().generate();
    await ExtensionService().generate();
  }
}
