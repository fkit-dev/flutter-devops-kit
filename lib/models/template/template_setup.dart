import 'template_bootstrap.dart';

/// Defines the setup configuration for an FKIT template.
class TemplateSetup {
  /// Creates a template setup configuration.
  const TemplateSetup({
    required this.modules,
    required this.features,
    required this.bootstrap,
  });

  /// The modules included in the template setup.
  final List<String> modules;

  /// The features included in the template setup.
  final List<String> features;

  /// The project bootstrap configuration for the template.
  final TemplateBootstrap bootstrap;

  /// Creates a template setup configuration from the provided [map].
  factory TemplateSetup.fromMap(Map<dynamic, dynamic> map) {
    return TemplateSetup(
      modules: List<String>.from(
        map['modules'] ?? const [],
      ),
      features: List<String>.from(
        map['features'] ?? const [],
      ),
      bootstrap: TemplateBootstrap.fromMap(
        Map<dynamic, dynamic>.from(
          map['bootstrap'] ?? const {},
        ),
      ),
    );
  }
}
