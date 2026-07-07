class TemplateRouter {
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

  final bool enabled;
  final String strategy;
  final String routeFile;
  final String routerFile;
  final String initialRoute;
  final String screenFolder;
  final String screenSuffix;
  final List<String> ignore;

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

  bool get isGoRouter => strategy == 'go_router';
  bool get isManual => strategy == 'manual';
}
