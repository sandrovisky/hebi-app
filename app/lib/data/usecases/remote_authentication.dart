import 'package:flutter/material.dart';

import './/domain/entities/entities.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/usecases.dart';

class RemoteAuthentication implements Authentication {
  final IAuthRepositoryy authRepository;

  RemoteAuthentication({required this.authRepository});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    try {
      final accountEntity = await authRepository.auth(params);
      return accountEntity;
    } catch (error) {
      debugPrint('remoteAuthentication: $error');
      rethrow;
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

  Map toMap() => {'user': user, 'password': password};
}
