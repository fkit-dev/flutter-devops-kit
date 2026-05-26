class FirebaseConfig {
  final String appDistributionId;

  final Map<String, String> options;

  FirebaseConfig({required this.appDistributionId, required this.options});

  factory FirebaseConfig.fromMap(Map<dynamic, dynamic> map) {
    final optionsMap = <String, String>{};

    if (map['options'] != null) {
      for (final item in map['options'].entries) {
        optionsMap[item.key.toString()] = item.value.toString();
      }
    }

    return FirebaseConfig(appDistributionId: map['app_distribution_id'] ?? '', options: optionsMap);
  }
}
