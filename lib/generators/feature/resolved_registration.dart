import '../../models/template/registration_lifecycle.dart';

class ResolvedRegistration {
  const ResolvedRegistration({
    required this.lifecycle,
    required this.abstraction,
    required this.implementation,
    required this.variable,
    required this.dependencies,
  });

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
