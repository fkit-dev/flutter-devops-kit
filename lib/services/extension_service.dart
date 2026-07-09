import '../generators/extension/media_query_extension_generator.dart';
import '../generators/extension/theme_extension_generator.dart';
import '../generators/localization/localization_extension_generator.dart';
import '../services/logger_service.dart';
import 'config_service.dart';

class ExtensionService {
  Future<void> generate() async {
    LoggerService.section(
      'Generate Extensions',
    );

    await ThemeExtensionGenerator.generate();

    await MediaQueryExtensionGenerator.generate();

    final config = await ConfigService.load();

    if (config.localizationEnabled) {
      await LocalizationExtensionGenerator.generate(
        config,
      );
    }

    LoggerService.success(
      'Extensions generated successfully.',
    );
  }
}
