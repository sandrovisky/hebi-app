abstract class LoginPresenter {
  Stream<String> get codeErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<ControllerState> get controllerStream;
  Stream<String> get mainErrorStream;

  void validateCode(String code);
  void validatePassword(String password);
  void auth();
}

abstract class ControllerState {}

class InitialControllerState implements ControllerState {}

class LoadingControllerState implements ControllerState {}

class ErrorControllerState implements ControllerState {
  final String error;

  ErrorControllerState(this.error);
}
