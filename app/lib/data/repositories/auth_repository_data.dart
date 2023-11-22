import './/data/cache/cache.dart';
import './/data/http/http.dart';
import './/data/models/models.dart';
import './/data/usecases/remote_authentication.dart';
import './/domain/entities/account_entity.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/authentication.dart';

class AuthRepositoryData implements IAuthRepository {
  final IHttpClient httpClientWithInterceptor;
  final IHttpClient httpClient;
  final ICacheStorage cacheStorage;

  AuthRepositoryData({
    required this.httpClient,
    required this.cacheStorage,
    required this.httpClientWithInterceptor,
  });

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final api = await cacheStorage.fetch('apiURL');
      final httpResponse = await httpClient.request(
        url: '$api/v2/android/login/',
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toMap(),
      );
      return RemoteAccountModel.fromMap(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }

  @override
  Future<void> checkUser(AccountEntity accountEntity) async {
    try {
      final api = await cacheStorage.fetch('apiURL');
      await httpClientWithInterceptor.request(
        url: '$api/v2/android/check-token/',
        method: 'get',
      );
      return;
    } catch (e) {
      throw DomainError.unexpected;
    }
  }
}
