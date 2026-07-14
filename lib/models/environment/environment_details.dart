/// Defines environment configuration for a project target.
class EnvironmentDetails {
  /// Path to the environment configuration file.
  final String file;

  /// Creates environment configuration.
  const EnvironmentDetails({
    required this.file,
  });

  /// Creates environment configuration from the provided [map].
  factory EnvironmentDetails.fromMap(
    Map<String, dynamic> map,
  ) {
    return EnvironmentDetails(
      file: map['file']?.toString() ?? '',
    );
  }

  /// Converts this environment configuration to a map.
  Map<String, dynamic> toMap() {
    return {
      'file': file,
    };
  }
}
