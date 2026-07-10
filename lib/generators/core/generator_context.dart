import '../../models/init_config.dart';
import '../../models/template/template_definition.dart';
import '../../services/naming_service.dart';

/// Provides configuration and naming information used during code generation.
///
/// Contains the project configuration, feature and artifact names, selected
/// template, and derived values required by FKIT generators.
class GeneratorContext {
  /// The project configuration used during generation.
  final InitConfig config;

  /// Feature name (auth, profile, dashboard).
  final String feature;

  /// Optional artifact name (login, register, user).
  final String? name;

  /// Selected template (bloc_clean, riverpod_clean, ...).
  final TemplateDefinition template;

  /// Creates a generator context.
  GeneratorContext({
    required this.config,
    required this.feature,
    this.name,
    required this.template,
  });

  /// Creates a copy of this context with the provided values replaced.
  GeneratorContext copyWith({
    InitConfig? config,
    String? feature,
    String? name,
    TemplateDefinition? template,
  }) {
    return GeneratorContext(
      config: config ?? this.config,
      feature: feature ?? this.feature,
      name: name ?? this.name,
      template: template ?? this.template,
    );
  }

  /// The directory path for the current feature.
  String get featurePath => '${config.featureDir}/$feature';

  /// The naming utilities derived from the current feature and artifact names.
  late final NamingService naming = NamingService(
    feature: feature,
    name: name,
  );
}
