import 'package:app/layers/data/datasource/local/login_datasource_imp.dart';
import 'package:app/layers/data/repositories/login_repository_imp.dart';
import 'package:app/layers/presentation/router/login_router.dart';
import 'package:app/layers/presentation/splash.dart';
import 'package:flutter/material.dart';

class Routers {
  static String get initialRoute => '/';

  static Map<String, Widget Function(BuildContext, dynamic)> routes = {
    '/': (_, args) => const SplashScreen(),
    '/login': (_, args) =>
        LoginRouter(repository: LoginRepositoryImp(LoginDatasourceImp())),
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
