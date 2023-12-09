import './/domain/entities/entities.dart';
import './/domain/usecases/usecases.dart';

abstract class IAuthRepository {
  Future<AccountEntity> auth(AuthenticationParams authenticationParams);
  Future<void> validateToken(AccountEntity accountEntity);
}
