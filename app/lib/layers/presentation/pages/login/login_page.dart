import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './components/components.dart';

import './login_presenter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hebi'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Provider(
        create: (context) => presenter,
        child: const Column(
          children: [
            Logo(),
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: <Widget>[
                    InputCode(),
                    PasswordInput(),
                    SubmitButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
