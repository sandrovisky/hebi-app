import './/ui/helpers/errors/errors.dart';
import './/ui/pages/error/error.dart';

sealed class LoginState {}

class InitialLoginState extends LoginState {}

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
    late UIError? newUserError;
    late UIError? newPasswordError;

    if (userError is UIError) {
      if (userError == UIError.noError) {
        newUserError = null;
      } else {
        newUserError = userError;
      }
    } else {
      newUserError = this.userError;
    }

    if (passwordError is UIError) {
      if (passwordError == UIError.noError) {
        newPasswordError = null;
      } else {
        newPasswordError = passwordError;
      }
    } else {
      newPasswordError = this.passwordError;
    }

    return FormLoginState(
      user: user ?? this.user,
      password: password ?? this.password,
      userError: newUserError,
      passwordError: newPasswordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  Map mapToValidate() => {
        'user': user,
        'password': password,
      };
}
