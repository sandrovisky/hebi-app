import 'package:app/layers/domain/repositories/login_repository.dart';
import 'package:app/layers/presentation/containers/login_container.dart';
import 'package:app/layers/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';

class LoginRouter extends StatelessWidget {
  const LoginRouter({
    Key? key,
    required this.repository,
  }) : super(key: key);
  final ILoginRepository repository;

  @override
  Widget build(BuildContext context) {
    return LoginContainer(
      controller: LoginController(
          repository, (error) => showErrorDialog(error, context)),
    );
  }

  Future<void> showErrorDialog(String error, BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              )
            ],
          );
        });
  }
}
