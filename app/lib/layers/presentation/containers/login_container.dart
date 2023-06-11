import 'package:flutter/material.dart';

import '../core/basic_controller.dart';

import '../pages/pages.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({
    Key? key,
    required this.presenter,
  }) : super(key: key);
  final LoginPresenter presenter;

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ControllerState>(
      initialData: InitialControllerState(),
      stream: widget.presenter.controllerStream,
      builder: (context, snapshot) {
        if (snapshot.data is LoadingControllerState) {
          print(snapshot);
          return const LoginLoadingPage();
        }

        if (snapshot.data is ErrorControllerState) {
          final event = snapshot.data as ErrorControllerState;
          return LoginErrorPage(error: event.error);
        }

        return LoginPage(presenter: widget.presenter);
      },
    );
  }
}
