import 'package:flutter/material.dart';

class FormLoginCodeInput extends StatelessWidget {
  const FormLoginCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // keyboardType: TextInputType.none,
      decoration: InputDecoration(
        border: InputBorder.none,
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
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
