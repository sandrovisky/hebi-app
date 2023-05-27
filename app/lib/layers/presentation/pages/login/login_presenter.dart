abstract class LoginPresenter {
  Stream<String> get codeErrorStream;

  void validateCode(String code);
  void validatePassword(String password);
}
