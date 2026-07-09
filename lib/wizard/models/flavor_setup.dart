import '../../models/flavor_details.dart';

class FlavorSetup {
  final bool enabled;
  final String defaultFlavor;
  final Map<String, FlavorDetails> flavors;

  const FlavorSetup({
    required this.enabled,
    required this.defaultFlavor,
    required this.flavors,
  });
}
