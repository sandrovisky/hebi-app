import 'package:hebi/domain/entities/account_entity.dart';

abstract class AuthEvent {}

class ChangeAccountAuthEvent extends AuthEvent {
  final AccountEntity? accountEntity;

  ChangeAccountAuthEvent(this.accountEntity);
}

class CheckSessionAuthEvent extends AuthEvent {}
