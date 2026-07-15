/// Defines launcher icon configuration for an FKIT project.
class LauncherIconConfig {
  /// Creates a launcher icon configuration.
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

  /// The path to the source launcher icon image.
  final String imagePath;

  /// Whether Android launcher icon generation is enabled.
  final bool android;

  /// Whether iOS launcher icon generation is enabled.
  final bool ios;

  /// Whether web launcher icon generation is enabled.
  final bool web;

  /// The background value used for Android adaptive icons.
  final String adaptiveBackground;

  /// The path to the foreground image used for Android adaptive icons.
  final String adaptiveForeground;

  /// The optional path to the monochrome image used for adaptive icons.
  final String? adaptiveMonochrome;

  /// Whether alpha transparency should be removed from generated iOS icons.
  final bool removeAlphaIos;

  /// Creates a launcher icon configuration from the provided [map].
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

  /// Converts this launcher icon configuration to a map.
  ///
  /// The returned map uses keys compatible with the
  /// `flutter_launcher_icons` configuration format.
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
