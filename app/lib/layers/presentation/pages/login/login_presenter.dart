import 'package:app/layers/presentation/core/basic_controller.dart';

abstract class LoginPresenter {
  Stream<String> get codeErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<ControllerState> get controllerStream;
  Stream<String> get mainErrorStream;

  void validateCode(String code);
  void validatePassword(String password);
  Future<void>? auth();
  void dispose();
}
