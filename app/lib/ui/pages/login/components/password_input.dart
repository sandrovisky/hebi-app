import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/blocs.dart';
import './/ui/helpers/errors/errors.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool obscure = true;
  IconData icon = Icons.visibility_off_outlined;

  changeShowPassword() {
    setState(() {
      obscure = !obscure;
      icon =
          obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state as FormLoginState;

    return SizedBox(
      height: 60,
      child: TextFormField(
        initialValue: state.password,
        obscureText: obscure,
        keyboardType: TextInputType.number,
        onChanged: (password) => bloc.add(
          PasswordChangeLoginEvent(password),
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(icon),
            onPressed: changeShowPassword,
          ),
          errorText: state.passwordError?.description,
          hintText: "Senha",
        ),
      ),
    );
  }
}
