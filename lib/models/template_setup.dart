class TemplateSetup {
  const TemplateSetup({
    required this.modules,
    required this.features,
  });

  final List<String> modules;
  final List<String> features;

  factory TemplateSetup.fromMap(Map<dynamic, dynamic> map) {
    return TemplateSetup(
      modules: List<String>.from(
        map['modules'] ?? const [],
      ),
      features: List<String>.from(
        map['features'] ?? const [],
      ),
    );
  }

  const TemplateSetup.empty()
      : modules = const [],
        features = const [];

  bool get isEmpty => modules.isEmpty && features.isEmpty;

  bool get isNotEmpty => !isEmpty;
}
