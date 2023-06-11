abstract class ControllerState {}

class InitialControllerState implements ControllerState {}

class LoadingControllerState implements ControllerState {}

class ErrorControllerState implements ControllerState {
  final String error;

  ErrorControllerState(this.error);
}
