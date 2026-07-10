import 'registration_lifecycle.dart';

/// Defines dependency injection registration metadata for a template component.
class TemplateRegistration {
  /// Creates a template registration configuration.
  const TemplateRegistration({
    required this.component,
    required this.folder,
    required this.lifecycle,
    this.implementation,
  });

  /// The component associated with the registration.
  final String component;

  /// The directory containing the component implementation.
  final String folder;

  /// The dependency injection lifecycle used for the registration.
  final RegistrationLifecycle lifecycle;

  /// The optional implementation associated with the registered component.
  final String? implementation;

  /// Creates a template registration from the provided [component] and [map].
  factory TemplateRegistration.fromMap(
    String component,
    Map<dynamic, dynamic> map,
  ) {
    return TemplateRegistration(
      component: component,
      folder: map['folder'].toString(),
      lifecycle: _parseLifecycle(map['lifecycle'].toString()),
      implementation: map['implementation']?.toString(),
    );
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

  /// Whether the component uses the factory registration lifecycle.
  bool get isFactory => lifecycle == RegistrationLifecycle.factory;

  /// Whether the component uses the singleton registration lifecycle.
  bool get isSingleton => lifecycle == RegistrationLifecycle.singleton;

  /// Whether the component uses the lazy singleton registration lifecycle.
  bool get isLazySingleton => lifecycle == RegistrationLifecycle.lazySingleton;
}
