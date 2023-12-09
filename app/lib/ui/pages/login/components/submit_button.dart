import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/login/login.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state as FormLoginState;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(100, 50)),
        onPressed: state.isFormValid ? () => bloc.add(AuthLoginEvent()) : null,
        child: const Text('LOGIN'),
      ),
    );
  }
}
