import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app/core/device_info/device_info.dart';
import 'package:app/core/inject/inject.dart';
import 'package:app/layers/presentation/router/login_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    DeviceInfo().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
        child: AnimatedSplashScreen(
      splash: Center(
        child: Image.asset(
          'assets/images/snake.png',
        ),
      ),
      splashIconSize: width,
      nextScreen: Inject.get<LoginRouter>(),
    ));
  }
}
