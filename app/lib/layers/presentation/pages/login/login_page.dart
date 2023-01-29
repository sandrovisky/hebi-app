// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/layers/presentation/pages/login/components/form_login.dart';
import 'package:app/layers/presentation/pages/login/components/logo.dart';
import 'package:app/layers/presentation/widgets/keyboard.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: Logo(),
          ),
          const FormLogin(),
          Expanded(
            flex: 4,
            child: ModifiedNumericKeyboard(
              onKeyboardTap: (text) {},
            ),
          ),
        ],
      ),
    );
  }
}
