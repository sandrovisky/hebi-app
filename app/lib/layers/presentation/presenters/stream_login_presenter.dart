import 'dart:async';

import 'package:app/layers/presentation/presenters/protocols/protocols.dart';

class LoginState {
  late String codeError;
}

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  Stream<String> get codeErrorStream => _controller.stream
      .map(
        (state) => state.codeError,
      )
      .distinct();

  StreamLoginPresenter({required this.validation});

  void validateCode(String code) {
    _state.codeError = validation.validate(field: 'code', value: code);
    _controller.add(_state);
  }
}
