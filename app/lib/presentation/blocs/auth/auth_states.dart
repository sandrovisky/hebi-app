import './/domain/helpers/helpers.dart';

sealed class AuthState {}

class RedirectAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final DomainError error;

  ErrorAuthState(this.error);
}

class LoggedInAuthState extends AuthState {}

class LoggedOutAuthState extends AuthState {}
