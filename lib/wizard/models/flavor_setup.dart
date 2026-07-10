import '../../models/flavor_details.dart';

/// Defines the flavor configuration for an FKIT project.
///
/// Contains settings for enabling flavors, selecting the default flavor,
/// and configuring the available project flavors.
class FlavorSetup {
  /// Whether flavor support is enabled.
  final bool enabled;

  /// The name of the default flavor used by the project.
  final String defaultFlavor;

  /// The available flavors mapped by their names.
  final Map<String, FlavorDetails> flavors;

  /// Creates a flavor configuration.
  const FlavorSetup({
    required this.enabled,
    required this.defaultFlavor,
    required this.flavors,
  });
}
