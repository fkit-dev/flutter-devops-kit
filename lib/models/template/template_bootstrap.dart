import 'template_bootstrap_file.dart';

class TemplateBootstrap {
  const TemplateBootstrap({
    required this.enabled,
    required this.app,
    required this.main,
  });

  final bool enabled;
  final TemplateBootstrapFile? app;
  final TemplateBootstrapFile? main;

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

  const TemplateBootstrap.empty()
      : enabled = false,
        app = null,
        main = null;
}
