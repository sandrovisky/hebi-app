import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/auth/auth.dart';
import './/ui/mixins/mixins.dart';
import './/ui/pages/pages.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> with DomainErrorHandler {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<AuthBloc>().add(CheckSessionAuthEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ErrorAuthState) {
          dialogDomainErrorHandler(context, state.error);
        }

        if (state is LoggedInAuthState) {
          Navigator.of(context).pushReplacementNamed('/home');
        }

        if (state is LoggedOutAuthState) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      builder: (context, state) {
        return const LoadingPage();
      },
    );
  }
}
