import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';
import 'package:hebi/ui/pages/widgets/widgets.dart';

class JbInsertGuessInsertButton extends StatelessWidget {
  const JbInsertGuessInsertButton({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertingGuessJBState;

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: DefaultButton(
        enabled: state.guessIsValid,
        onPressed: () {
          final guess = state.typedGuess;
          bloc.add(InsertGuessJbEvent(guess));
          controller.clear();
        },
        label: 'INSERIR',
        icon: const Icon(Icons.add),
      ),
    );
  }
}
