import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String?>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              obscureText: true,
              keyboardType: TextInputType.number,
              onChanged: presenter.validatePassword,
              decoration: InputDecoration(
                errorText: snapshot.hasData ? snapshot.data : null,
                helperText: ' ',
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório!';
                }
                return 'teste';
              },
            ),
          );
        });
  }
}
