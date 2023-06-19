import 'dart:async';

import 'package:app/layers/domain/helpers/domain_error.dart';

import '../../domain/usecases/authentication.dart';

import '../../presentation/presenters/protocols/protocols.dart';

class LoginState {
  String code = '';
  String password = '';
  String codeError = '';
  String passwordError = '';
  String mainError = '';
  bool isLoading = false;

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
  Stream<String> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  StreamLoginPresenter(
      {required this.validation, required this.authentication});

  void _update() {
    _controller.add(_state);
    print('sandro ${_state.isLoading}');
  }

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
    try {
      _state.isLoading = true;
      _update();

      await authentication.auth(
          params: AuthenticationParams(
              user: _state.code, password: _state.password));
    } on DomainError catch (e) {
      _state.mainError = e.description;
    } finally {
      _state.isLoading = false;
      _update();
    }
  }
}
