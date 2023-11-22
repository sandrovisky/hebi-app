import 'package:flutter/material.dart';
import 'package:hebi/ui/pages/authwrapper/authwrapper_page.dart';

import './/ui/pages/splash/splash_page.dart';
import './/ui/routers/routers.dart';

class Routers {
  static String get initialRoute => '/';

  static Map<String, Widget Function(BuildContext, dynamic)> routes = {
    '/': (_, args) => const SplashScreen(),
    '/check': (_, args) => const AuthWrapperPage(),
    '/login': (context, args) => const LoginRouter(),
    '/home': (context, args) => const HomeRouter()
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
