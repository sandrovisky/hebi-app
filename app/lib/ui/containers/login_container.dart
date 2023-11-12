import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './/ui/pages/pages.dart';
import './/presentation/blocs/blocs.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state;

    if (state is LoadingLoginState) return const LoadingPage();

    if (state is FormLoginState) return LoginPage(bloc: bloc);

    if (state is ErrorLoginState) {
      return ErrorPage(
        error: state,
        onPressed: () => bloc.add(ClearErrorLoginEvent()),
      );
    }

    return ErrorPage(onPressed: () => bloc.add(ClearErrorLoginEvent()));
  }
}
