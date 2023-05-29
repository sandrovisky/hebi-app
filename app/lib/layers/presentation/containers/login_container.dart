import 'package:flutter/material.dart';

import '../pages/pages.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    Key? key,
    required this.presenter,
  }) : super(key: key);
  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: presenter.controllerStream,
      builder: (context, snapshot) {
        if (snapshot.data?.isLoading == true) {
          return const LoginLoadingPage();
        }

        if (snapshot.data?.hasError == true) {
          return LoginErrorPage(
            error: snapshot.data!.error,
          );
        }

        return LoginPage(
          presenter: presenter,
        );
      },
    );
  }
}
