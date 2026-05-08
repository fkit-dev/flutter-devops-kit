class FlavorConfig {
  final String env;
  final String firebaseAppId;

  FlavorConfig({required this.env, required this.firebaseAppId});

  factory FlavorConfig.fromMap(Map<dynamic, dynamic> map) {
    return FlavorConfig(env: map['env'] ?? '', firebaseAppId: map['firebase_app_id'] ?? '');
  }
}
