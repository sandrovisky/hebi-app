import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/login/login.dart';

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
            hintText: "Codigo",
          ),
        ),
      );
    }
    return Container();
  }
}
