import 'package:flutter/material.dart';

import './/domain/helpers/helpers.dart';

class ErrorDialog {
  final DomainError error;
  final BuildContext context;

  const ErrorDialog({required this.error, required this.context});

  List<Widget> _buildBody() {
    if (error.shouldRedirect) {
      return [
        Text('Erro na sessão: ${error.description}'),
        const Text('Necessário logar novamente.'),
        const SizedBox(height: 15),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          },
          child: const Text('Fechar'),
        ),
      ];
    }

    return [
      Text(error.description),
      const SizedBox(height: 15),
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('Voltar'),
      ),
    ];
  }

  Widget build() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBody(),
        ),
      ),
    );
  }
}
