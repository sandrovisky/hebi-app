import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/blocs.dart';
import './/ui/helpers/errors/errors.dart';

class CodeInput extends StatelessWidget {
  const CodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state;

    if (state is FormLoginState) {
      return SizedBox(
        height: 60,
        child: TextFormField(
          keyboardType: TextInputType.number,
          initialValue: state.user,
          onChanged: (user) => bloc.add(
            UserChangeLoginEvent(user),
          ),
          decoration: InputDecoration(
            errorText: state.userError?.description,
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
        ),
      );
    }
    return Container();
  }
}
