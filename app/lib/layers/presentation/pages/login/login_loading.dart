import 'package:flutter/material.dart';

class LoginLoadingPage extends StatelessWidget {
  const LoginLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
