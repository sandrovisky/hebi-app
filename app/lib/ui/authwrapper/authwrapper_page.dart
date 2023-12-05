import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/ui/mixins/mixins.dart';

import './/presentation/blocs/blocs.dart';
import './/ui/pages/pages.dart';

class AuthWrapperPage extends StatefulWidget {
  const AuthWrapperPage({super.key});

  @override
  State<AuthWrapperPage> createState() => _AuthWrapperPageState();
}

class _AuthWrapperPageState extends State<AuthWrapperPage>
    with DomainErrorHandler {
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
