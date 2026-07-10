import '../../models/template/registration_lifecycle.dart';

/// Represents a resolved dependency injection registration.
class ResolvedRegistration {
  /// Creates a resolved dependency injection registration.
  const ResolvedRegistration({
    required this.lifecycle,
    required this.abstraction,
    required this.implementation,
    required this.variable,
    required this.dependencies,
  });

  /// The lifecycle used to register the dependency.
  final RegistrationLifecycle lifecycle;

  /// HomeRepository
  final String abstraction;

  /// HomeRepositoryImpl
  final String implementation;

  /// homeRepository
  final String variable;

  /// homeRemoteDatasource: sl(),
  /// homeLocalDatasource: sl(),
  final List<String> dependencies;
}
