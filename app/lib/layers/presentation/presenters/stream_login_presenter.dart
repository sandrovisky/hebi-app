import 'dart:async';

import '../../domain/usecases/authentication.dart';

import '../../presentation/presenters/protocols/protocols.dart';

class LoginState {
  String code = '';
  String password = '';
  String codeError = '';
  String passwordError = '';

  bool get isFormValid =>
      codeError.isEmpty &&
      passwordError.isEmpty &&
      code.isNotEmpty &&
      password.isNotEmpty;
}

class StreamLoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String> get codeErrorStream =>
      _controller.stream.map((state) => state.codeError).distinct();
  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter(
      {required this.validation, required this.authentication});

  void _update() => _controller.add(_state);

  void validateCode(String code) {
    _state.code = code;
    _state.codeError = validation.validate(field: 'code', value: code);
    _update();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  Future<void>? auth() async {
    await authentication.auth(
        params:
            AuthenticationParams(user: _state.code, password: _state.password));
  }
}
