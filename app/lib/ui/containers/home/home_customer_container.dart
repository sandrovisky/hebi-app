import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hebi/presentation/blocs/blocs.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente: ${bloc.accountEntity!.customer}'),
        actions: [
          IconButton.outlined(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
              bloc.add(ChangeAccountAuthEvent(null));
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<AuthBloc>().add(CheckAccountAuthEvent());
          },
          child: Text('teste')),
    );
  }
}
