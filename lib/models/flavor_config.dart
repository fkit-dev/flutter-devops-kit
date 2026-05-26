import 'firebase_config.dart';

class FlavorConfig {
  final String env;

  final FirebaseConfig firebase;

  FlavorConfig({required this.env, required this.firebase});

  factory FlavorConfig.fromMap(Map<dynamic, dynamic> map) {
    return FlavorConfig(env: map['env'] ?? '', firebase: FirebaseConfig.fromMap(map['firebase'] ?? {}));
  }
}
