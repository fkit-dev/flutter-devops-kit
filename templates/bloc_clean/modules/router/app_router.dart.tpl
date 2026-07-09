import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// <fkit:imports>
// </fkit:imports>

import 'app_route.dart';

class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoute.splash.path,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.routeName,
        builder: (_, _) => const _FkitSplashScreen(),
      ),

      // <fkit:routes>
      // </fkit:routes>
    ],
  );
}

class _FkitSplashScreen extends StatelessWidget {
  const _FkitSplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('FKIT Splash'),
      ),
    );
  }
}