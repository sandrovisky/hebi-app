import 'package:flutter/material.dart';

import './/data/http/http.dart';
import './/data/models/models.dart';
import './/data/repositories/repositories.dart';
import './/data/usecases/usecases.dart';
import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/authentication.dart';

class AuthRepository with IBaseRepository implements IAuthRepository {
  final IHttpClient httpClient;

  AuthRepository({required this.httpClient});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final httpResponse = await httpClient.request(
        url: '/v2/android/login/',
        method: 'post',
        body: RemoteAuthenticationParams.fromDomain(params).toMap(),
      );

      return RemoteAccountModel.fromMap(httpResponse).toEntity();
    } on Http401Error catch (error) {
      throw handle401Error(error);
    } on HttpError catch (error) {
      if (error == HttpError.socketError) {
        throw DomainError.loginSocketAdapterError;
      }
      throw DomainError.unexpected;
    }
  }

  @override
  Future<void> validateToken(AccountEntity accountEntity) async {
    try {
      await httpClient.request(
        url: '/v2/android/check-token/',
        method: 'get',
      );
      return;
    } on Http401Error catch (error) {
      throw handle401Error(error);
    } on HttpError catch (error) {
      debugPrint('authRepository: $error');
      if (error == HttpError.socketError) {
        throw DomainError.socketAdapterError;
      }
      throw DomainError.unexpected;
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
