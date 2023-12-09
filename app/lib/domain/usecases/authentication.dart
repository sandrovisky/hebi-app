import 'package:equatable/equatable.dart';

import '../entities/account_entity.dart';

abstract class IAuthentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams extends Equatable {
  final String user;
  final String password;

  const AuthenticationParams({
    required this.user,
    required this.password,
  });

  @override
  List<String> get props => [user, password];
}
