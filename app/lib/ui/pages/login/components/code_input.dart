import 'package:flutter/material.dart';

class CodeInput extends StatelessWidget {
  const CodeInput({Key? key, required this.onChanged}) : super(key: key);

  final Future<void> Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorText: ' ',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório!';
        }
        return null;
      },
    );
  }
}
