import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/ui/widgets/widgets.dart';
import './/presentation/blocs/blocs.dart';
import 'components/menu_item_jogo.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        title: Text('Cliente: ${bloc.accountEntity!.customer}'),
        actions: [
          IconButton(
            onPressed: () {
              bloc.add(ChangeAccountAuthEvent(null));
              Navigator.of(context).pushReplacementNamed('/login');
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: const [
          MenuItemJogo(),
          MenuItem(title: 'CAIXA', svgName: 'clover_outlined'),
          MenuItem(title: 'REPETIR', svgName: 'repeat'),
          MenuItem(title: 'RESULTADO', svgName: 'casino'),
          MenuItem(title: 'EXTRATO', svgName: 'receipt'),
          MenuItem(title: 'EXCLUIR', svgName: 'trash'),
          MenuItem(title: 'REIMPRIMIR', svgName: 'printer'),
          MenuItem(title: 'TICKETS', svgName: 'help'),
          MenuItem(title: 'TABELA COTAÇÃO', svgName: 'quote'),
          MenuItem(title: 'OUTROS', svgName: 'dots'),
        ],
      ),
    );
  }
}
