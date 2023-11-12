import './/data/cache/cache.dart';
import './/data/http/http.dart';
import './/data/models/models.dart';
import './/data/usecases/remote_authentication.dart';
import './/domain/entities/account_entity.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/authentication.dart';

class LoginRepositoryData implements ILoginRepository {
  final IHttpClient httpClient;
  final ICacheStorage cacheStorage;

  LoginRepositoryData({required this.httpClient, required this.cacheStorage});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final api = await cacheStorage.fetch('apiURL');
      final httpResponse = await httpClient.request(
        url: '$api/login',
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toJson(),
      );
      return RemoteAccountModel.fromMap(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
