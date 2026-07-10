/// Defines routing configuration for an FKIT template.
class TemplateRouter {
  /// Creates a template routing configuration.
  const TemplateRouter({
    required this.enabled,
    required this.strategy,
    required this.routeFile,
    required this.routerFile,
    required this.initialRoute,
    required this.screenFolder,
    required this.screenSuffix,
    required this.ignore,
  });

  /// Whether routing integration is enabled.
  final bool enabled;

  /// The routing strategy used by the template.
  final String strategy;

  /// The path to the generated or maintained route file.
  final String routeFile;

  /// The path to the application's router configuration file.
  final String routerFile;

  /// The initial route configured for the application.
  final String initialRoute;

  /// The directory containing generated screen files.
  final String screenFolder;

  /// The suffix used to identify screen files.
  final String screenSuffix;

  /// The routes or files excluded from routing integration.
  final List<String> ignore;

  /// Creates a template routing configuration from the provided [map].
  factory TemplateRouter.fromMap(Map<dynamic, dynamic> map) {
    final screens = Map<dynamic, dynamic>.from(map['screens'] ?? const {});

    return TemplateRouter(
      enabled: map['enabled'] == true,
      strategy: map['strategy']?.toString() ?? 'manual',
      routeFile: map['route_file']?.toString() ?? '',
      routerFile: map['router_file']?.toString() ?? '',
      initialRoute: map['initial_route']?.toString() ?? '',
      screenFolder: screens['folder']?.toString() ?? '',
      screenSuffix: screens['suffix']?.toString() ?? '',
      ignore: List<String>.from(map['ignore'] ?? const []),
    );
  }

  /// Whether the configured routing strategy uses GoRouter.
  bool get isGoRouter => strategy == 'go_router';

  /// Whether the configured routing strategy uses manual routing.
  bool get isManual => strategy == 'manual';
}
