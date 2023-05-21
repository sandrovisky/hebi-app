import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import '../http/http.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future auth(AuthenticationParams params) async {
    try {
      await httpClient.request(
        url: url,
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toJson(),
      );
    } on HttpError {
      throw DomainError.unexpected;
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
