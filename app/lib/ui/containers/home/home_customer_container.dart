import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/auth/auth.dart';
import './/ui/pages/home/customer/customer.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    if (bloc.accountEntity!.isCustomer) return const CustomerPage();

    return Container();
  }
}
