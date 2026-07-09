class LauncherIconConfig {
  const LauncherIconConfig({
    required this.imagePath,
    required this.android,
    required this.ios,
    required this.web,
    required this.adaptiveBackground,
    required this.adaptiveForeground,
    this.adaptiveMonochrome,
    required this.removeAlphaIos,
  });

  final String imagePath;

  final bool android;
  final bool ios;
  final bool web;

  final String adaptiveBackground;
  final String adaptiveForeground;
  final String? adaptiveMonochrome;

  final bool removeAlphaIos;

  factory LauncherIconConfig.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    final web = Map<dynamic, dynamic>.from(
      map['web'] ?? const {},
    );

    return LauncherIconConfig(
      imagePath: map['image_path']?.toString() ?? '',
      android: map['android'] == true,
      ios: map['ios'] == true,
      web: web['generate'] == true,
      adaptiveBackground:
          map['adaptive_icon_background']?.toString() ?? '#FFFFFF',
      adaptiveForeground: map['adaptive_icon_foreground']?.toString() ?? '',
      adaptiveMonochrome: map['adaptive_icon_monochrome']?.toString(),
      removeAlphaIos: map['remove_alpha_ios'] == true,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'image_path': imagePath,
      'android': android,
      'ios': ios,
      'adaptive_icon_background': adaptiveBackground,
      'adaptive_icon_foreground': adaptiveForeground,
      if (adaptiveMonochrome != null && adaptiveMonochrome!.isNotEmpty)
        'adaptive_icon_monochrome': adaptiveMonochrome,
      'remove_alpha_ios': removeAlphaIos,
      'web': {
        'generate': web,
        'image_path': imagePath,
        'background_color': adaptiveBackground,
        'theme_color': '#000000',
      },
    };
  }
}
