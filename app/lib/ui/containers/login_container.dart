import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/ui/pages/pages.dart';
import './/presentation/blocs/blocs.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingLoginState) return const LoadingPage();

        if (state is FormLoginState) return const LoginPage();

        if (state is ErrorLoginState) {
          return ErrorPage(
            error: state,
            onPressed: () => bloc.add(ClearErrorLoginEvent()),
          );
        }

        return ErrorPage(
          onPressed: () => bloc.add(ClearErrorLoginEvent()),
        );
      },
    );
  }
}
