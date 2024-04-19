import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';
import 'package:hebi/ui/pages/widgets/widgets.dart';

class JbInsertGuessContinueButton extends StatelessWidget {
  const JbInsertGuessContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertingGuessJBState;

    return DefaultButton(
      enabled: state.guesses.isNotEmpty,
      onPressed: () {
        bloc.add(FinishGuessesJbEvent(
          guesses: state.guesses,
          modality: state.modality.acronym,
          submodality: state.submodality,
        ));
      },
      label: 'CONTINUAR',
    );
  }
}
