import 'firebase_details.dart';

/// Defines configuration details for an application flavor.
class FlavorDetails {
  /// The environment configuration associated with the flavor.
  final String env;

  /// The Firebase configuration for the flavor.
  final FirebaseDetails firebase;

  /// Creates an application flavor configuration.
  const FlavorDetails({
    required this.env,
    required this.firebase,
  });

  /// Creates an application flavor configuration from the provided [map].
  factory FlavorDetails.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    return FlavorDetails(
      env: map['env']?.toString() ?? '',
      firebase: FirebaseDetails.fromMap(
        Map<String, dynamic>.from(
          map['firebase'] ?? {},
        ),
      ),
    );
  }
}
