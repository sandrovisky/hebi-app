import 'package:flutter/material.dart';

import './/data/cache/cache.dart';
import './/data/http/http.dart';
import './/data/models/models.dart';
import './/data/repositories/repositories.dart';
import './/data/usecases/usecases.dart';
import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/authentication.dart';

class AuthRepository extends BaseRepository implements IAuthRepositoryy {
  final IHttpClient httpClient;
  final ICacheStorage cacheStorage;

  AuthRepository({
    required this.httpClient,
    required this.cacheStorage,
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
    } on Http401Error catch (error) {
      throw handle401Error(error);
    } on HttpError catch (error) {
      if (error == HttpError.socketError) {
        throw DomainError.socketAdapterError;
      }
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> validateToken(AccountEntity accountEntity) async {
    try {
      final api = await cacheStorage.fetch('apiURL');
      await httpClient.request(
        url: '$api/v2/android/check-token/',
        method: 'get',
      );
      return;
    } on Http401Error catch (error) {
      throw handle401Error(error);
    } on HttpError catch (error) {
      if (error == HttpError.socketError) {
        throw DomainError.socketAdapterError;
      }
      debugPrint('authRepository: $error');
      throw DomainError.unexpected;
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
