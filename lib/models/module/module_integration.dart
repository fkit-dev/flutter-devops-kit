class ModuleIntegration {
  const ModuleIntegration({
    required this.enabled,
    required this.strategy,
  });

  final bool enabled;
  final String strategy;

  factory ModuleIntegration.fromMap(Map<dynamic, dynamic> map) {
    return ModuleIntegration(
      enabled: map['enabled'] ?? false,
      strategy: map['strategy']?.toString() ?? '',
    );
  }

  const ModuleIntegration.empty()
      : enabled = false,
        strategy = '';
}
