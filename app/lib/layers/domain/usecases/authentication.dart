import '../entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth({
    required String user,
    required String password,
  });
}
