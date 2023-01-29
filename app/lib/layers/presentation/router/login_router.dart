import 'package:app/core/inject/inject.dart';
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
    return Inject.get<LoginContainer>();
  }
}
