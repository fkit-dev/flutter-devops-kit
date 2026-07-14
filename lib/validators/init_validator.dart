import '../models/init_config.dart';
import '../services/logger_service.dart';
import '../utils/platform_utils.dart';
import 'file_validator.dart';

/// Validates FKIT project initialization configuration.
class InitValidator {
  /// Validates the provided project [config].
  ///
  /// Throws an exception when the configuration contains invalid or
  /// unsupported values.
  static void validate(InitConfig config) {
    _validateFlavoring(config);
    _validateMainEntry(config);
    _validateEnvironment(config);
    _validateFirebase(config);
  }

  static void _validateFlavoring(InitConfig config) {
    if (!config.flavoringEnabled && config.flavors.length > 1) throw Exception('❌ Flavoring disabled but multiple flavors configured');

    if (!config.flavors.contains(config.defaultFlavor)) {
      throw Exception(
        '❌ Default flavor "${config.defaultFlavor}" '
        'is not configured',
      );
    }

    LoggerService.success('Flavoring validated');
  }

  static void _validateMainEntry(InitConfig config) {
    if (!FileValidator.exists(config.mainEntry)) throw Exception('❌ Main entry not found: ${config.mainEntry}');

    LoggerService.success('Main entry validated');
  }

  static void _validateEnvironment(InitConfig config) {
    final environment = config.environment;

    if (!environment.enabled) return;

    for (final entry in environment.configurations.entries) {
      final target = entry.key;
      final details = entry.value;

      if (!config.flavors.contains(target)) throw Exception('❌ Environment target "$target" is not configured');

      if (details.file.isEmpty) throw Exception('❌ Environment file not configured for "$target"');

      if (!FileValidator.exists(details.file)) {
        throw Exception(
          '❌ Environment file missing for '
          '$target: ${details.file}',
        );
      }

      LoggerService.success('Environment validated: $target');
    }
  }

  static void _validateFirebase(InitConfig config) {
    final firebase = config.firebase;

    if (!firebase.enabled) {
      return;
    }

    for (final entry in firebase.configurations.entries) {
      final target = entry.key;
      final details = entry.value;

      if (!config.flavors.contains(target)) {
        throw Exception(
          '❌ Firebase target "$target" is not configured',
        );
      }

      _validateFirebasePlatform(
        config: config,
        target: target,
        platformName: 'android',
        options: details.android?.options,
      );

      _validateFirebasePlatform(
        config: config,
        target: target,
        platformName: 'ios',
        options: details.ios?.options,
      );

      _validateFirebasePlatform(
        config: config,
        target: target,
        platformName: 'web',
        options: details.web?.options,
      );

      LoggerService.success('Firebase validated: $target');
    }
  }

  static void _validateFirebasePlatform(
      {required InitConfig config, required String target, required String platformName, required String? options}) {
    if (!PlatformUtils.isEnabled(config, platformName)) return;

    if (options == null || options.isEmpty) return;

    if (!FileValidator.exists(options)) {
      throw Exception(
        '❌ $platformName Firebase options missing '
        'for "$target": $options',
      );
    }
  }
}
