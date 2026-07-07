import '../../models/init_config.dart';
import '../../models/template/template_definition.dart';
import '../../services/naming_service.dart';

class GeneratorContext {
  final InitConfig config;

  /// Feature name (auth, profile, dashboard)
  final String feature;

  /// Optional artifact name (login, register, user)
  final String? name;

  /// Selected template (bloc_clean, riverpod_clean, ...)
  final TemplateDefinition template;

  GeneratorContext({required this.config, required this.feature, this.name, required this.template});

  GeneratorContext copyWith({InitConfig? config, String? feature, String? name, TemplateDefinition? template}) {
    return GeneratorContext(
        config: config ?? this.config, feature: feature ?? this.feature, name: name ?? this.name, template: template ?? this.template);
  }

  String get featurePath => '${config.featureDir}/$feature';
  late final NamingService naming = NamingService(feature: feature, name: name);
}
