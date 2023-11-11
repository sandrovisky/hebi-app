import 'package:flutter/material.dart';

import './components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

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
      body: const Column(
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
    );
  }
}
