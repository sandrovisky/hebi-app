import './/ui/helpers/errors/errors.dart';
import './/ui/pages/error/error.dart';

sealed class LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState implements ErrorState {
  final String error;

  ErrorLoginState(this.error);

  @override
  String get message => error;
}

class SuccessLoginState extends LoginState {}

class FormLoginState extends LoginState {
  final String user;
  final String password;
  final UIError? userError;
  final UIError? passwordError;
  final bool isFormValid;

  FormLoginState({
    this.user = '',
    this.password = '',
    this.userError,
    this.passwordError,
    this.isFormValid = false,
  });

  FormLoginState copyWith({
    String? user,
    String? password,
    UIError? userError,
    UIError? passwordError,
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
