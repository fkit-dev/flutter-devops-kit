import 'template_registration.dart';

class TemplateDi {
  const TemplateDi(
      {required this.strategy,
      required this.file,
      required this.imports,
      required this.enabled,
      required this.ignore,
      required this.registrations});

  /// DI framework
  /// get_it | riverpod | getx | injectable | manual
  final String strategy;

  final bool enabled;

  /// Output file relative to feature root.
  final String file;

  /// Folders scanned to generate imports.
  final List<String> imports;

  /// Glob patterns ignored while scanning.
  final List<String> ignore;

  /// Registration definitions.
  final Map<String, TemplateRegistration> registrations;

  factory TemplateDi.fromMap(Map<dynamic, dynamic> map) {
    final registrationsMap = Map<dynamic, dynamic>.from(map['registrations'] ?? const {});

    return TemplateDi(
      strategy: (map['strategy']?.toString() ?? 'manual').trim().toLowerCase(),
      file: map['file']?.toString() ?? 'di/feature_di.dart',
      imports: List<String>.from(map['imports'] ?? const []),
      enabled: map['enabled'],
      ignore: List<String>.from(map['ignore'] ?? const []),
      registrations: registrationsMap
          .map((key, value) => MapEntry(key.toString(), TemplateRegistration.fromMap(key.toString(), Map<dynamic, dynamic>.from(value)))),
    );
  }

  bool get isManual => strategy == 'manual';

  bool get isGetIt => strategy == 'get_it';

  bool get isRiverpod => strategy == 'riverpod';

  bool get isGetX => strategy == 'getx';

  bool get isInjectable => strategy == 'injectable';

  bool hasRegistration(String component) => registrations.containsKey(component);

  TemplateRegistration? getRegistration(String component) => registrations[component];

  Iterable<TemplateRegistration> get allRegistrations => registrations.values;
}
