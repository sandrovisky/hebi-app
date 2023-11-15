import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/blocs.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state as FormLoginState;
    print(state.isFormValid);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: Size(100, 50)),
        onPressed: state.isFormValid ? () => bloc.add(AuthLoginEvent()) : null,
        child: const Text('LOGIN'),
      ),
    );
  }
}
