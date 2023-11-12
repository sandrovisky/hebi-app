import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

import './/core/core.dart';
import './/ui/routers/routers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceInfo = context.read<DeviceInfo>();
    final storage = context.read<LocalStorage>();

    return Center(
      child: AnimatedSplashScreen(
        splash: Center(
          child: Image.asset(
            'assets/images/snake.png',
          ),
        ),
        splashIconSize: MediaQuery.sizeOf(context).width,
        nextScreen: const LoginRouter(),
        function: () async {
          await deviceInfo.init();
          await storage.ready;
        },
      ),
    );
  }
}
