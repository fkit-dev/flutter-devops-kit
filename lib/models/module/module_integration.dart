/// Defines the integration configuration for an FKIT module.
class ModuleIntegration {
  /// Creates a module integration configuration.
  const ModuleIntegration({
    required this.enabled,
    required this.strategy,
  });

  /// Whether module integration is enabled.
  final bool enabled;

  /// The strategy used to integrate the module into the project.
  final String strategy;

  /// Creates a module integration configuration from the provided [map].
  factory ModuleIntegration.fromMap(Map<dynamic, dynamic> map) {
    return ModuleIntegration(
      enabled: map['enabled'] ?? false,
      strategy: map['strategy']?.toString() ?? '',
    );
  }

  /// Creates an empty module integration configuration.
  const ModuleIntegration.empty()
      : enabled = false,
        strategy = '';
}
