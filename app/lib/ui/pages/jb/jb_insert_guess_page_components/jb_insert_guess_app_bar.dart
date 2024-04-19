import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';

class JbInsertGuessAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const JbInsertGuessAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertingGuessJBState;

    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.read<JBBloc>().add(BackToModalityDetailPageJbEvent());
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        '${state.modality.acronym} + ${state.submodality}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
