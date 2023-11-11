import 'package:flutter/material.dart';

import 'package:app/presentation/routers/login_router.dart';
import 'package:app/presentation/splash.dart';

class Routers {
  static String get initialRoute => '/';

  static Map<String, Widget Function(BuildContext, dynamic)> routes = {
    '/': (_, args) => const SplashScreen(),
    '/login': (context, args) => const LoginRouter()
  };

  static Route? generateRoutes(RouteSettings settings) {
    final routerName = settings.name;
    final routerArgs = settings.arguments;

    final navigateTo = routes[routerName];

    if (navigateTo == null) return null;

    return MaterialPageRoute(
      builder: (context) => navigateTo.call(context, routerArgs),
    );
  }
}
