abstract class ControllerState {}

class SuccessControllerState implements ControllerState {}

class LoadingControllerState implements ControllerState {}

class ErrorControllerState implements ControllerState {
  final String error;

  ErrorControllerState(this.error);
}
