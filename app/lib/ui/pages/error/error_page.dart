// ignore_for_file: public_member_api_docs, sort_constructors_first
import './/ui/pages/error/state.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    this.error,
    required this.onPressed,
  }) : super(key: key);

  final ErrorState? error;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error?.message ?? 'Erro Desconhecido.'),
            ElevatedButton(onPressed: onPressed, child: const Text('Voltar'))
          ],
        ),
      ),
    );
  }
}
