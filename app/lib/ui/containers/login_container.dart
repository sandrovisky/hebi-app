import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/login/login.dart';
import './/presentation/blocs/auth/auth.dart';
import './/ui/pages/pages.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocAuth = context.read<AuthBloc>();

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is SuccessLoginState) {
          blocAuth.add(ChangeAccountAuthEvent(state.entity));
          Navigator.of(context).pushReplacementNamed('/home');
        }

        if (state is ErrorLoginState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error.description),
          ));
        }
      },
      builder: (context, state) {
        if (state is FormLoginState) return const LoginPage();

        return const LoadingPage();
      },
    );
  }
}
