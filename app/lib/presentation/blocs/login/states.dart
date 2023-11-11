abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final String error;

  ErrorLoginState(this.error);
}

class SuccessLoginState extends LoginState {}

class FormLoginState extends LoginState {
  final String user;
  final String password;
  final String userError;
  final String passwordError;
  final bool isFormValid;

  FormLoginState({
    this.user = '',
    this.password = '',
    this.userError = '',
    this.passwordError = '',
    this.isFormValid = false,
  });

  FormLoginState copyWith({
    String? user,
    String? password,
    String? userError,
    String? passwordError,
    bool? isFormValid,
  }) {
    return FormLoginState(
      user: user ?? this.user,
      password: password ?? this.password,
      userError: userError ?? this.userError,
      passwordError: passwordError ?? this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
