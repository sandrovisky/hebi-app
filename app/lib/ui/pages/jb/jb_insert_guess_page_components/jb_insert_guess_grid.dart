import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';

class JbInsertGuessGrid extends StatelessWidget {
  const JbInsertGuessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertingGuessJBState;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Wrap(
            spacing: 12,
            children: state.guesses
                .map(
                  (guess) => Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        bloc.add(RemoveGuessJbEvent(guess));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(guess),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
