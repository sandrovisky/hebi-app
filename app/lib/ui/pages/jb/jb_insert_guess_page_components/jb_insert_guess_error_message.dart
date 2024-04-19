import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/domain/helpers/helpers.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';

class JbInsertGuessErrorMessage extends StatelessWidget {
  const JbInsertGuessErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertingGuessJBState;

    return Row(
      children: [
        Flexible(
          child: DefaultTextStyle(
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
            child: Text(
              buildErrorMesage(state.guessErrors, state.modality.maxValue),
              overflow: TextOverflow.clip,
            ),
          ),
        ),
      ],
    );
  }

  String buildErrorMesage(List<GuessError> guessErrors, int maxValue) {
    String message = '';

    if (guessErrors.contains(GuessError.invalidLength)) {
      message += 'TAMANHO INVALIDO';
    }

    if (guessErrors.contains(GuessError.pairRequired)) {
      if (message.isNotEmpty) message += '  /  ';
      message += 'DEVE CONTER APENAS PARES. EX:102030, 112233';
    }

    if (guessErrors.contains(GuessError.greaterThan)) {
      if (message.isNotEmpty) message += '  /  ';
      message += 'DEVE CONTER DEZENAS MENORES QUE $maxValue';
    }
    return message;
  }
}
