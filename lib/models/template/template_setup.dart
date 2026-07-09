import 'template_bootstrap.dart';

class TemplateSetup {
  const TemplateSetup({
    required this.modules,
    required this.features,
    required this.bootstrap,
  });

  final List<String> modules;
  final List<String> features;
  final TemplateBootstrap bootstrap;

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
