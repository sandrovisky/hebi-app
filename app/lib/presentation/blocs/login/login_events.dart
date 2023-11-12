abstract class LoginEvent {}

class PasswordChangeLoginEvent extends LoginEvent {
  final String password;

  PasswordChangeLoginEvent(this.password);
}

class UserChangeLoginEvent extends LoginEvent {
  final String user;

  UserChangeLoginEvent(this.user);
}

class AuthLoginEvent extends LoginEvent {}

class ClearErrorLoginEvent extends LoginEvent {}
