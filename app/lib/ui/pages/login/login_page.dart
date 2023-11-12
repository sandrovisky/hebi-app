import 'package:flutter/material.dart';

import './/presentation/blocs/blocs.dart';

import './components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, required this.bloc}) : super(key: key);

  final LoginBloc bloc;

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
      body: Column(
        children: [
          const Logo(),
          Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: <Widget>[
                  CodeInput(
                    onChanged: (user) async => bloc.add(
                      UserChangeLoginEvent(user),
                    ),
                  ),
                  PasswordInput(
                    onChanged: (password) async => bloc.add(
                      PasswordChangeLoginEvent(password),
                    ),
                  ),
                  LoginButton(
                    onPressed: () async => bloc.add(AuthLoginEvent()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
