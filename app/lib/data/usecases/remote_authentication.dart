import './/data/http/http.dart';
import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/usecases.dart';

class RemoteAuthentication implements Authentication {
  final ILoginRepository loginRepository;

  RemoteAuthentication({required this.loginRepository});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final accountEntity = await loginRepository.auth(params);
      return accountEntity;
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String user;
  final String password;

  RemoteAuthenticationParams({
    required this.user,
    required this.password,
  });

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams entity) {
    return RemoteAuthenticationParams(
      user: entity.user,
      password: entity.password,
    );
  }

  Map toJson() => {'user': user, 'password': password};
}
