import '../generators/core/generator_context.dart';
import '../generators/feature/feature_generator.dart';
import '../models/init_config.dart';
import '../models/template/template_definition.dart';
import 'flutter_service.dart';
import 'maintenance_service.dart';

/// Manages feature generation for FKIT projects.
class FeatureGenerationService {
  /// Creates a feature generation service.
  const FeatureGenerationService();

  /// Generates a feature using the provided generation configuration.
  ///
  /// Returns whether the feature generation process completed successfully.
  Future<bool> generate(
      {required InitConfig config,
      required TemplateDefinition template,
      required String feature,
      bool postGenerate = true}) async {
    final context =
        GeneratorContext(config: config, feature: feature, template: template);

    final generated = await FeatureGenerator().generate(context);

    if (!generated) return false;
    await MaintenanceService().synchronize(context);

    if (postGenerate) await FlutterService(config).buildRunner();
    return true;
  }
}
