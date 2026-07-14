import 'environment_details.dart';

/// Defines environment configuration for an FKIT project.
class EnvironmentConfig {
  /// Whether environment configuration is enabled.
  final bool enabled;

  /// Environment configurations keyed by target name.
  final Map<String, EnvironmentDetails> configurations;

  /// Creates an FKIT environment configuration.
  const EnvironmentConfig({
    required this.enabled,
    required this.configurations,
  });

  /// Creates environment configuration from the provided [map].
  factory EnvironmentConfig.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    final configurationsMap = Map<dynamic, dynamic>.from(
      map['configurations'] ?? const {},
    );

    return EnvironmentConfig(
      enabled: map['enabled'] ?? false,
      configurations: configurationsMap.map(
        (key, value) => MapEntry(
          key.toString(),
          EnvironmentDetails.fromMap(
            Map<String, dynamic>.from(value),
          ),
        ),
      ),
    );
  }

  /// Returns environment configuration for the specified [target].
  EnvironmentDetails? configurationFor(String target) {
    return configurations[target];
  }
}
