/// Defines Firebase configuration for a specific application platform.
class FirebasePlatform {
  /// The Firebase application identifier for the platform.
  final String appId;

  /// The path to the generated Firebase options file.
  final String options;

  /// Creates a Firebase platform configuration.
  const FirebasePlatform({
    required this.appId,
    required this.options,
  });

  /// Creates a Firebase platform configuration from the provided [map].
  factory FirebasePlatform.fromMap(
    Map<String, dynamic> map,
  ) {
    return FirebasePlatform(
      appId: map['app_id'] ?? '',
      options: map['options'] ?? '',
    );
  }

  /// Converts this Firebase platform configuration to a map.
  Map<String, dynamic> toMap() {
    return {
      'app_id': appId,
      'options': options,
    };
  }
}
