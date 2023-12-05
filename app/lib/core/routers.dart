import 'package:flutter/material.dart';

import './/ui/pages/pages.dart';
import './/ui/routers/routers.dart';

class Routers {
  static String get initialRoute => '/';

  static Map<String, Widget Function(BuildContext, dynamic)> routes = {
    '/': (_, args) => const SplashScreen(),
    '/error': (_, args) => ErrorPage(error: args),
    '/check': (_, args) => const AuthWrapperPage(),
    '/login': (context, args) => const LoginRouter(),
    '/home': (context, args) => const HomeRouter(),
    '/config': (context, args) => const ConfigRouter(),
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
