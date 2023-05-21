// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth({required AuthenticationParams params});
}

class AuthenticationParams {
  final String user;
  final String password;

  AuthenticationParams({
    required this.user,
    required this.password,
  });
}
