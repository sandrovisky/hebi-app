import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/presentation/blocs/blocs.dart';
import './/ui/helpers/errors/errors.dart';

class CodeInput extends StatelessWidget {
  const CodeInput({Key? key, required this.onChanged}) : super(key: key);

  final Future<void> Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final state = context.read<LoginBloc>().state;

    if (state is FormLoginState) {
      return TextFormField(
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: state.userError?.description,
          helperText: ' ',
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
          hintText: "Codigo",
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
      );
    }
    return Container();
  }
}
