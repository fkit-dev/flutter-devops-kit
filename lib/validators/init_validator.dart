import '../models/init_config.dart';
import '../services/logger_service.dart';
import '../utils/platform_utils.dart';
import 'file_validator.dart';

class InitValidator {
  static void validate(InitConfig config) {
    _validateFlavoring(config);

    _validateMainEntry(config);

    _validateFlavorEnvFiles(config);

    _validateFirebaseOptions(config);
  }

  static void _validateFlavoring(InitConfig config) {
    if (!config.flavoringEnabled && config.flavors.length > 1) {
      throw Exception('❌ Flavoring disabled but multiple flavors configured');
    }

    LoggerService.success('Flavoring validated');
  }

  static void _validateMainEntry(InitConfig config) {
    if (!FileValidator.exists(config.mainEntry)) {
      throw Exception(
        '❌ Main entry not found: '
        '${config.mainEntry}',
      );
    }

    LoggerService.success('Main entry validated');
  }

  static void _validateFlavorEnvFiles(InitConfig config) {
    for (final flavor in config.flavors.entries) {
      final envFile = flavor.value.env;

      if (!FileValidator.exists(envFile)) {
        throw Exception(
          '❌ Env file missing for '
          '${flavor.key}: $envFile',
        );
      }

      LoggerService.success('Env validated: ${flavor.key}');
    }
  }

  static void _validateFirebaseOptions(
    InitConfig config,
  ) {
    for (final flavor in config.flavors.entries) {
      for (final entry in flavor.value.firebase.entries()) {
        if (!PlatformUtils.isEnabled(
          config,
          entry.name,
        )) {
          continue;
        }

        if (entry.platform.options.isEmpty) {
          continue;
        }

        if (!FileValidator.exists(entry.platform.options)) {
          throw Exception(
            '❌ ${entry.name} Firebase options missing: '
            '${entry.platform.options}',
          );
        }
      }

      LoggerService.success(
        'Firebase validated: ${flavor.key}',
      );
    }
  }
}
