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
    return StreamBuilder<ControllerState>(
      initialData: InitialControllerState(),
      stream: presenter.controllerStream,
      builder: (context, snapshot) {
        if (snapshot.data is LoadingControllerState) {
          print(snapshot);
          return const LoginLoadingPage();
        }

        if (snapshot.data is ErrorControllerState) {
          final event = snapshot.data as ErrorControllerState;
          return LoginErrorPage(error: event.error);
        }

        return LoginPage(presenter: presenter);
      },
    );
  }
}
