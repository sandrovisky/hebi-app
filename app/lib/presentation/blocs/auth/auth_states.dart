import './/ui/pages/pages.dart';

sealed class AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState implements ErrorState {
  final String error;

  ErrorAuthState(this.error);

  @override
  String get message => error;
}

class LoggedInAuthState extends AuthState {}

class LoggedOutAuthState extends AuthState {}
