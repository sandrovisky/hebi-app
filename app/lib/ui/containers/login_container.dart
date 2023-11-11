import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './/presentation/blocs/login/login.dart';
import './/ui/pages/error/error.dart';

import '../pages/pages.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<LoginBloc>();
    final state = bloc.state;

    void clearError() {
      bloc.add(ClearErrorLoginEvent());
    }

    if (state is LoadingLoginState) return const LoginLoadingPage();

    if (state is ErrorLoginState) {
      return ErrorPage(error: state, onPressed: clearError);
    }

    if (state is FormLoginState) return LoginPage(bloc: bloc);

    return ErrorPage(onPressed: clearError);
  }
}
