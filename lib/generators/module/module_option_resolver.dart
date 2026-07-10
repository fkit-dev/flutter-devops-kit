import '../../models/module/module_definition.dart';
import '../../models/module/module_option.dart';
import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';

/// Resolves configured option values for an FKIT module.
class ModuleOptionResolver {
  /// Creates a module option resolver.
  const ModuleOptionResolver();

  /// Resolves option values for the provided [module].
  ///
  /// Returns an empty map when the module does not define any configurable
  /// options.
  Future<Map<String, dynamic>> resolve(ModuleDefinition module) async {
    if (!module.hasOptions) return const {};

    final values = <String, dynamic>{};

    LoggerService.blank();
    LoggerService.section('${module.displayName} Configuration');

    for (final option in module.options.values) {
      values[option.name] = _resolveOption(option);
    }

    return values;
  }

  dynamic _resolveOption(ModuleOption option) {
    if (option.isBoolean) return _resolveBoolean(option);
    throw UnsupportedError('Unsupported module option type "${option.type}".');
  }

  bool _resolveBoolean(ModuleOption option) {
    final defaultValue = option.defaultValue == true;
    final answer = PromptService.ask(option.prompt, defaultValue: defaultValue ? 'y' : 'n');

    final normalized = answer.trim().toLowerCase();

    return normalized == 'y' || normalized == 'yes';
  }
}
