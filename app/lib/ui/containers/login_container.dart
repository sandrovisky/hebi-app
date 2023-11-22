import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/ui/pages/pages.dart';
import './/presentation/blocs/blocs.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final blocAuth = context.read<AuthBloc>();
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is SuccessLoginState) {
          blocAuth.add(ChangeAccountAuthEvent(state.entity));
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      builder: (context, state) {
        if (state is FormLoginState) return const LoginPage();

        if (state is ErrorLoginState) {
          return ErrorPage(
            error: state,
            onPressed: () => bloc.add(ClearErrorLoginEvent()),
          );
        }

        return const LoadingPage();
      },
    );
  }
}
