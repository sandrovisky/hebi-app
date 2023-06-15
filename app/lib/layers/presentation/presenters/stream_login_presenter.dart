import 'dart:async';

import 'package:app/layers/presentation/presenters/protocols/protocols.dart';

class LoginState {
  late String codeError;
  late String passwordError;

  bool get isFormValid => false;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String> get codeErrorStream =>
      _controller.stream.map((state) => state.codeError).distinct();

  Stream<String> get passwordErrorStream =>
      _controller.stream.map((state) => state.codeError).distinct();

  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({required this.validation});

  void validateCode(String code) {
    _state.codeError = validation.validate(field: 'code', value: code);
    _controller.add(_state);
  }

  void validatePassword(String password) {
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _controller.add(_state);
  }
}
