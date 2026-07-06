import 'registration_lifecycle.dart';

class TemplateRegistration {
  const TemplateRegistration({required this.component, required this.folder, required this.lifecycle, this.implementation});

  final String component;

  final String folder;

  final RegistrationLifecycle lifecycle;

  final String? implementation;

  factory TemplateRegistration.fromMap(String component, Map<dynamic, dynamic> map) {
    return TemplateRegistration(
        component: component,
        folder: map['folder'].toString(),
        lifecycle: _parseLifecycle(map['lifecycle'].toString()),
        implementation: map['implementation']?.toString());
  }

  static RegistrationLifecycle _parseLifecycle(String value) {
    switch (value.trim().toLowerCase()) {
      case 'factory':
        return RegistrationLifecycle.factory;

      case 'singleton':
        return RegistrationLifecycle.singleton;

      case 'lazy_singleton':
        return RegistrationLifecycle.lazySingleton;

      default:
        throw Exception('Unknown lifecycle "$value".');
    }
  }

  bool get isFactory => lifecycle == RegistrationLifecycle.factory;

  bool get isSingleton => lifecycle == RegistrationLifecycle.singleton;

  bool get isLazySingleton => lifecycle == RegistrationLifecycle.lazySingleton;
}
