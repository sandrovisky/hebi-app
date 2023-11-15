import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/blocs.dart';

import './components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final state = bloc.state;

    if (state is FormLoginState) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hebi'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
          ],
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Logo(),
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                      children: <Widget>[
                        CodeInput(),
                        PasswordInput(),
                        LoginButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
