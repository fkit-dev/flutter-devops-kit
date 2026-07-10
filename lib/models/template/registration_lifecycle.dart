/// Defines the supported dependency injection registration lifecycles.
enum RegistrationLifecycle {
  /// Creates a new instance each time the dependency is requested.
  factory,

  /// Uses a single shared instance of the dependency.
  singleton,

  /// Creates a shared instance when the dependency is first requested.
  lazySingleton,
}
