import './/domain/entities/account_entity.dart';
import './/domain/usecases/usecases.dart';

abstract class ILoginRepository {
  Future<AccountEntity> auth(AuthenticationParams authenticationParams);
}
