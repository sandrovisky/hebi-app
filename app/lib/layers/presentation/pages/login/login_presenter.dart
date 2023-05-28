abstract class LoginPresenter {
  Stream<String?> get codeErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;

  void validateCode(String code);
  void validatePassword(String password);
}
