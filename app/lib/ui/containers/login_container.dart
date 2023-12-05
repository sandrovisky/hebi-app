import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/blocs.dart';
import '../mixins/mixins.dart';
import './/ui/pages/pages.dart';

class LoginContainer extends StatelessWidget with DomainErrorHandler {
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
          dialogDomainErrorHandler(context, state.error);

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
