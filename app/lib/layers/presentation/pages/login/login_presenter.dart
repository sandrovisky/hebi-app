abstract class LoginPresenter {
  Stream<String> get codeErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<BasicController> get controllerStream;
  Stream<String> get mainErrorStream;

  void validateCode(String code);
  void validatePassword(String password);
}

class BasicController {
  bool _isLoading = false;
  bool _hasError = false;
  String _error = '';

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get error => _error;

  void setLoading(bool value) {
    _isLoading = value;
  }

  void _setHasError(bool value) {
    _hasError = value;
  }

  void setError(String value) {
    if (value.isEmpty) {
      _setHasError(false);
    } else {
      _setHasError(true);
    }
    _error = value;
  }
}
