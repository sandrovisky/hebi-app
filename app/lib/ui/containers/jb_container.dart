import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/ui/mixins/mixins.dart';

import './/presentation/blocs/jb/jb.dart';
import './/ui/pages/pages.dart';

class JBContainer extends StatefulWidget {
  const JBContainer({Key? key}) : super(key: key);

  @override
  State<JBContainer> createState() => _JBContainerState();
}

class _JBContainerState extends State<JBContainer> with DomainErrorHandler {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<JBBloc>().add(GetShiftsJbEvent()));
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = context.read<JBBloc>();

    return BlocConsumer<JBBloc, JBState>(
      listener: (context, state) async {
        if (state is ErrorJBState) {
          await dialogDomainErrorHandler(context, state.error);
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is LoadedShiftJBState) return const ShiftsPage();

        return const LoadingPage();
      },
    );
  }
}
