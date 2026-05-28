import '../models/project_config.dart';
import '../services/logger_service.dart';
import 'file_validator.dart';

class ProjectValidator {
  static void validate(ProjectConfig config) {
    _validateFlavoring(config);

    _validateMainEntry(config);

    _validateFlavorEnvFiles(config);

    _validateFirebaseOptions(config);
  }

  static void _validateFlavoring(ProjectConfig config) {
    if (!config.flavoringEnabled && config.flavors.length > 1) {
      throw Exception('❌ Flavoring disabled but multiple flavors configured');
    }

    LoggerService.success('Flavoring validated');
  }

  static void _validateMainEntry(ProjectConfig config) {
    if (!FileValidator.exists(config.mainEntry)) {
      throw Exception(
        '❌ Main entry not found: '
        '${config.mainEntry}',
      );
    }

    LoggerService.success('Main entry validated');
  }

  static void _validateFlavorEnvFiles(ProjectConfig config) {
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

  static void _validateFirebaseOptions(ProjectConfig config) {
    for (final flavor in config.flavors.entries) {
      final firebaseOptions = flavor.value.firebase.options;

      for (final option in firebaseOptions.entries) {
        if (!FileValidator.exists(option.value)) {
          throw Exception(
            '❌ Firebase options missing: '
            '${option.value}',
          );
        }
      }

      LoggerService.success(
        'Firebase validated: '
        '${flavor.key}',
      );
    }
  }
}
