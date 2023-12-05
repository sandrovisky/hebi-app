import './/domain/entities/account_entity.dart';
import './/domain/usecases/usecases.dart';

abstract class IAuthRepositoryy {
  Future<AccountEntity> auth(AuthenticationParams authenticationParams);
  Future<void> validateToken(AccountEntity accountEntity);
}
