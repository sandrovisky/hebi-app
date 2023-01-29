import 'package:app/layers/presentation/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class FormLoginButton extends StatelessWidget {
  const FormLoginButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            GetIt.instance.get<ILoginController>().login();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Data')),
            );
          }
        },
        child: const Text('Submit'),
      ),
    );
  }
}
