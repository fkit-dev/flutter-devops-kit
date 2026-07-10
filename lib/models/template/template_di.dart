import 'template_registration.dart';

/// Defines dependency injection configuration for an FKIT template.
class TemplateDi {
  /// Creates a template dependency injection configuration.
  const TemplateDi({
    required this.strategy,
    required this.file,
    required this.imports,
    required this.enabled,
    required this.ignore,
    required this.registrations,
  });

  /// The dependency injection strategy used by the template.
  ///
  /// Supported strategies include `get_it`, `riverpod`, `getx`, `injectable`,
  /// and `manual`.
  final String strategy;

  /// Whether dependency injection integration is enabled.
  final bool enabled;

  /// The output file path relative to the feature root.
  final String file;

  /// The directories scanned when generating imports.
  final List<String> imports;

  /// The glob patterns excluded while scanning files.
  final List<String> ignore;

  /// The component registration definitions keyed by component name.
  final Map<String, TemplateRegistration> registrations;

  /// Creates a template dependency injection configuration from [map].
  factory TemplateDi.fromMap(Map<dynamic, dynamic> map) {
    final registrationsMap = Map<dynamic, dynamic>.from(map['registrations'] ?? const {});

    return TemplateDi(
      strategy: (map['strategy']?.toString() ?? 'manual').trim().toLowerCase(),
      file: map['file']?.toString() ?? 'di/feature_di.dart',
      imports: List<String>.from(map['imports'] ?? const []),
      enabled: map['enabled'],
      ignore: List<String>.from(map['ignore'] ?? const []),
      registrations: registrationsMap.map(
        (key, value) => MapEntry(
          key.toString(),
          TemplateRegistration.fromMap(
            key.toString(),
            Map<dynamic, dynamic>.from(value),
          ),
        ),
      ),
    );
  }

  /// Whether the configured dependency injection strategy is manual.
  bool get isManual => strategy == 'manual';

  /// Whether the configured dependency injection strategy uses GetIt.
  bool get isGetIt => strategy == 'get_it';

  /// Whether the configured dependency injection strategy uses Riverpod.
  bool get isRiverpod => strategy == 'riverpod';

  /// Whether the configured dependency injection strategy uses GetX.
  bool get isGetX => strategy == 'getx';

  /// Whether the configured dependency injection strategy uses Injectable.
  bool get isInjectable => strategy == 'injectable';

  /// Returns whether a registration exists for [component].
  bool hasRegistration(String component) => registrations.containsKey(component);

  /// Returns the registration associated with [component].
  ///
  /// Returns `null` when the component has no registration.
  TemplateRegistration? getRegistration(String component) => registrations[component];

  /// All dependency injection registrations defined by the template.
  Iterable<TemplateRegistration> get allRegistrations => registrations.values;
}
