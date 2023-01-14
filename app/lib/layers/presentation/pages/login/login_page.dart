// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required this.login,
  }) : super(key: key);
  final Future<Map> Function({required String user, required String password})
      login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.green,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.red,
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              await login(user: 'adm', password: 'adm');
            },
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
