class FirebasePlatform {
  final String appId;
  final String options;

  const FirebasePlatform({
    required this.appId,
    required this.options,
  });

  factory FirebasePlatform.fromMap(
    Map<String, dynamic> map,
  ) {
    return FirebasePlatform(
      appId: map['app_id'] ?? '',
      options: map['options'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'app_id': appId,
      'options': options,
    };
  }
}
