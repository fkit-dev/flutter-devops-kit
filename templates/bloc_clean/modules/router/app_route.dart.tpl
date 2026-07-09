enum AppRoute {
  splash('/'),

  // <fkit:routes>
  // </fkit:routes>

  ;

  const AppRoute(this.path);

  final String path;

  String get routeName => name;
}