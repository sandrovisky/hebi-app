import 'package:app/layers/presentation/pages/login/components/form_login_button.dart';
import 'package:app/layers/presentation/pages/login/components/form_login_code_input.dart';
import 'package:app/layers/presentation/pages/login/components/form_login_password_input.dart';
import 'package:flutter/material.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            children: <Widget>[
              const FormLoginCodeInput(),
              const Padding(
                padding: EdgeInsets.only(
                  top: 15,
                ),
              ),
              const FormLoginPasswordInput(),
              FormLoginButton(formKey: _formKey),
            ],
          ),
        ),
      ),
    );
  }
}
