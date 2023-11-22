import './/domain/entities/account_entity.dart';
import './/domain/usecases/usecases.dart';

abstract class IAuthRepository {
  Future<AccountEntity> auth(AuthenticationParams authenticationParams);
  Future<void> checkUser(AccountEntity accountEntity);
}
