abstract class LoginPresenter {
  Stream<String?> get codeErrorStream;
  Stream<String?> get passwordErrorStream;

  void validateCode(String code);
  void validatePassword(String password);
}
