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

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state;

    if (state is FormLoginState) {
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
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
            ),
            errorText: state.passwordError?.description,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
            hintText: "Senha",
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
