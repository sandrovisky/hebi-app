import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login_presenter.dart';

class InputCode extends StatelessWidget {
  const InputCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginPresenter presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String?>(
        stream: presenter.codeErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            keyboardType: TextInputType.number,
            onChanged: presenter.validateCode,
            decoration: InputDecoration(
              errorText: snapshot.hasData ? snapshot.data : null,
              helperText: ' ',
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              hintText: "Codigo",
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
              return null;
            },
          );
        });
  }
}
