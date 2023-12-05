import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

import './/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceInfo = context.read<DeviceInfo>();
    final storage = context.read<LocalStorage>();
    final theme = context.read<ThemeController>();

    return Center(
      child: AnimatedSplashScreen.withScreenRouteFunction(
        splash: Center(
          child: Image.asset(
            'assets/images/snake.png',
          ),
        ),
        splashIconSize: MediaQuery.sizeOf(context).width,
        screenRouteFunction: () async {
          await theme.init();
          await deviceInfo.init();
          await storage.ready;

          final defaultParameter = {'apiURL': 'http://192.168.1.100:7000/api'};

          for (var keyMap in defaultParameter.keys) {
            await storage.setItem(keyMap, defaultParameter[keyMap]);
          }

          return '/check';
        },
      ),
    );
  }
}
