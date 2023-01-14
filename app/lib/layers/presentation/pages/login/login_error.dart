import 'package:flutter/material.dart';

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(error)),
    );
  }
}
