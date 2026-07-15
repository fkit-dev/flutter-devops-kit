/// Defines configurable sections of an FKIT project.
enum ConfigSection {
  /// Flavors Configuration
  flavors,

  /// Environment Configuration
  environment,

  /// Firebase Configuration
  firebase,

  /// Localization Configuration
  localization;

  /// Resolves a configuration section from the provided [value].
  static ConfigSection? fromName(String value) {
    return switch (value.trim().toLowerCase()) {
      'flavors' => ConfigSection.flavors,
      'environment' => ConfigSection.environment,
      'firebase' => ConfigSection.firebase,
      'localization' => ConfigSection.localization,
      _ => null,
    };
  }

  /// Returns the top-level YAML key associated with this section.
  String get yamlKey {
    return switch (this) {
      ConfigSection.flavors => 'flavoring',
      ConfigSection.environment => 'environment',
      ConfigSection.firebase => 'firebase',
      ConfigSection.localization => 'localization',
    };
  }
}
