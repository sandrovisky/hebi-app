import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:app/layers/presentation/controllers/login_controller.dart';
import 'package:app/layers/presentation/pages/login/components/components.dart';

import './login_presenter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  final LoginPresenter? presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String codeErrorMessage = '';
  String passwordErrorMessage = '';

  bool test = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hebi'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          const Logo(),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    onChanged: widget.presenter!.validateCode,
                    onTap: () => _formKey.currentState!.deactivate(),
                    decoration: InputDecoration(
                      errorText:
                          codeErrorMessage.isEmpty ? null : codeErrorMessage,
                      helperText: ' ',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      hintText: "Codigo",
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
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
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    onChanged: widget.presenter!.validatePassword,
                    decoration: InputDecoration(
                      errorText: passwordErrorMessage.isEmpty
                          ? null
                          : passwordErrorMessage,
                      helperText: ' ',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 10, 5),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
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
                      return 'teste';
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: codeController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                GetIt.instance.get<ILoginController>().login();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            }
                          : null,
                      child: const Text('LOGIN'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
