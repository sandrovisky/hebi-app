import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app/core/core.dart';

void main() {
  Inject.init();
  runApp(MultiProvider(
    providers: [],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'HebiApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routers.initialRoute,
      onGenerateRoute: Routers.generateRoutes,
    );
  }
}
