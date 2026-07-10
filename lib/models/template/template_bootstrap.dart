import 'template_bootstrap_file.dart';

/// Defines project bootstrap configuration for an FKIT template.
class TemplateBootstrap {
  /// Creates a template bootstrap configuration.
  const TemplateBootstrap({
    required this.enabled,
    required this.app,
    required this.main,
  });

  /// Whether project bootstrapping is enabled.
  final bool enabled;

  /// The optional bootstrap configuration for the application file.
  final TemplateBootstrapFile? app;

  /// The optional bootstrap configuration for the main entry-point file.
  final TemplateBootstrapFile? main;

  /// Creates a template bootstrap configuration from the provided [map].
  factory TemplateBootstrap.fromMap(Map<dynamic, dynamic> map) {
    return TemplateBootstrap(
      enabled: map['enabled'] ?? false,
      app: _parseFile(map['app']),
      main: _parseFile(map['main']),
    );
  }

  static TemplateBootstrapFile? _parseFile(dynamic value) {
    if (value is! Map) {
      return null;
    }

    return TemplateBootstrapFile.fromMap(
      Map<dynamic, dynamic>.from(value),
    );
  }

  /// Creates an empty template bootstrap configuration.
  const TemplateBootstrap.empty()
      : enabled = false,
        app = null,
        main = null;
}
