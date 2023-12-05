import 'package:flutter/material.dart';

import './/ui/helpers/errors/errors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  final UIError error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(error.description),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Voltar'),
            )
          ],
        ),
      ),
    );
  }
}
