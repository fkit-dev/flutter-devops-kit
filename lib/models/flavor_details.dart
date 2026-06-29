import 'firebase_details.dart';

class FlavorDetails {
  final String env;

  final FirebaseDetails firebase;

  const FlavorDetails({
    required this.env,
    required this.firebase,
  });

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
