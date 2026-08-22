import '../../models/module/module_definition.dart';
import '../../models/module/module_option.dart';
import '../../models/module/module_option_type.dart';
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
    return resolveWithDefaults(module, defaultsOnly: false);
  }

  /// Resolves module option values, optionally using defaults without prompts.
  Future<Map<String, dynamic>> resolveWithDefaults(
    ModuleDefinition module, {
    required bool defaultsOnly,
  }) async {
    if (!module.hasOptions) return const {};

    final values = <String, dynamic>{};

    if (!defaultsOnly) {
      LoggerService.blank();
      LoggerService.section('${module.displayName} Configuration');
    }

    for (final option in module.options.values) {
      values[option.name] =
          defaultsOnly ? _resolveDefault(option) : _resolveOption(option);
    }

    return values;
  }

  dynamic _resolveDefault(ModuleOption option) {
    switch (option.type) {
      case ModuleOptionType.bool:
        return option.defaultValue == true;
      case ModuleOptionType.string:
      case ModuleOptionType.enumType:
        return option.defaultValue?.toString() ?? '';
      case ModuleOptionType.color:
        final value = option.defaultValue?.toString() ?? '#000000';
        return value == 'auto' ? value : _toDartColor(value);
      case ModuleOptionType.int:
      case ModuleOptionType.double:
        return option.defaultValue;
    }
  }

  dynamic _resolveOption(ModuleOption option) {
    switch (option.type) {
      case ModuleOptionType.bool:
        return _resolveBoolean(option);

      case ModuleOptionType.string:
        return _resolveString(option);

      case ModuleOptionType.int:
        return _resolveInt(option);

      case ModuleOptionType.double:
        return _resolveDouble(option);

      case ModuleOptionType.color:
        return _resolveColor(option);

      case ModuleOptionType.enumType:
        return _resolveEnum(option);
    }
  }

  bool _resolveBoolean(ModuleOption option) {
    final defaultValue = option.defaultValue == true;
    final answer = PromptService.ask(option.prompt,
        defaultValue: defaultValue ? 'y' : 'n');

    final normalized = answer.trim().toLowerCase();

    return normalized == 'y' || normalized == 'yes';
  }

  String _resolveString(ModuleOption option) {
    return PromptService.ask(
      option.prompt,
      defaultValue: option.defaultValue?.toString() ?? '',
    );
  }

  dynamic _resolveInt(ModuleOption option) => throw UnsupportedError(
        'Module option type "int" is not yet supported.',
      );

  dynamic _resolveDouble(ModuleOption option) => throw UnsupportedError(
        'Module option type "double" is not yet supported.',
      );

  String _resolveColor(ModuleOption option) {
    final defaultValue = option.defaultValue?.toString() ?? '';

    while (true) {
      final answer = PromptService.ask(
        option.prompt,
        defaultValue: defaultValue,
      ).trim();

      if (answer == 'auto') {
        return answer;
      }

      if (_isValidColor(answer)) {
        return _toDartColor(answer);
      }

      LoggerService.error(
        'Invalid color. Use #RRGGBB or #AARRGGBB.',
      );
    }
  }

  dynamic _resolveEnum(ModuleOption option) => throw UnsupportedError(
        'Module option type "enumType" is not yet supported.',
      );

  /// Returns whether the provided [value] is a valid hexadecimal color.
  ///
  /// Supported formats:
  /// - `#RRGGBB`
  /// - `#AARRGGBB`
  bool _isValidColor(String value) {
    return RegExp(
      r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$',
    ).hasMatch(value);
  }

  String _toDartColor(String value) {
    final hex = value.replaceFirst('#', '').toUpperCase();
    if (hex.length == 6) return '0xFF$hex';
    return '0x$hex';
  }
}
