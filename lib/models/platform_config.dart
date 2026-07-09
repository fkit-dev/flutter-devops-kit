class PlatformConfig {
  final bool android;
  final bool ios;
  final bool web;

  PlatformConfig({required this.android, required this.ios, required this.web});

  factory PlatformConfig.fromMap(Map<dynamic, dynamic> map) {
    return PlatformConfig(
        android: map['android'] ?? false,
        ios: map['ios'] ?? false,
        web: map['web'] ?? false);
  }
}
