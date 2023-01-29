import 'package:app/core/inject/inject.dart';
import 'package:app/layers/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class LoginErrorPage extends StatelessWidget {
  const LoginErrorPage({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            ElevatedButton(
                onPressed: () => Inject.get<ILoginController>().clearError(),
                child: const Text('Voltar'))
          ],
        ),
      ),
    );
  }
}
