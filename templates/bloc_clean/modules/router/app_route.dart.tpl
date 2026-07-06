enum AppRoute {
  splash('/'),
  login('/login'),
  home('/home');

  const AppRoute(this.path);

  final String path;

  String get routeName => name;
}