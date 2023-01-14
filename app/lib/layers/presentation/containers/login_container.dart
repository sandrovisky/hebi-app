// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/layers/presentation/controllers/login_controller.dart';
import 'package:app/layers/presentation/pages/login/login_error.dart';
import 'package:app/layers/presentation/pages/login/login_loading.dart';
import 'package:app/layers/presentation/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: ((context, child) {
        if (controller.isLoading) {
          return const LoginLoadingPage();
        }

        if (controller.hasError) {
          return LoginErrorPage(
            error: controller.error,
          );
        }

        return LoginPage(
          login: controller.login,
        );
      }),
    );
  }
}
