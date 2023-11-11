import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import './/core/core.dart';
import './/presentation/blocs/login/bloc.dart';

void main() {
  Inject.init();
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => DeviceInfo()),
      BlocProvider(
        create: (context) => LoginBloc(),
      )
    ],
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
