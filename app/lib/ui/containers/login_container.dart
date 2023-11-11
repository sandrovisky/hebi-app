import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/pages.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
    // return ValueListenableBuilder<LoginState>(
    //   valueListenable: controller,
    //   builder: (_, value, child) {
    //     if (value is LoadingControllerState) {
    //       return const LoginLoadingPage();
    //     }

    //     if (value is LoginErrorState) {
    //       return LoginErrorPage(error: value.error);
    //     }

    //     return const LoginPage();
    //   },
    // );
  }
}
