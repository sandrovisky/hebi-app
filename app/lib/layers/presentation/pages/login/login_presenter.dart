abstract class LoginPresenter {
  Stream<String?> get codeErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<BasicController> get controllerStream;

  void validateCode(String code);
  void validatePassword(String password);
}

class BasicController {
  bool _isLoading = false;
  bool _hasError = false;
  String error = '';

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  void setLoading(bool value) {
    _isLoading = value;
  }
}
