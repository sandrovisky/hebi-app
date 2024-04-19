import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/jb/jb.dart';

class JbInsertGuessField extends StatefulWidget {
  const JbInsertGuessField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<JbInsertGuessField> createState() => _JbInsertGuessFieldState();
}

class _JbInsertGuessFieldState extends State<JbInsertGuessField> {
  final focus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<JBBloc>();
    final state = bloc.state as InsertingGuessJBState;
    focus.requestFocus();

    return TextFormField(
      focusNode: focus,
      controller: widget.controller,
      onChanged: (guess) {
        bloc.add(ChangeGuessJbEvent(guess));
      },
      keyboardType: const TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(state.modality.maxLength),
      ],
      decoration: const InputDecoration(hintText: 'INSIRA O PALPITE'),
    );
  }
}
