import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteAccountEntity {
  final String token;

  RemoteAccountEntity({required this.token});

  factory RemoteAccountEntity.fromJson(Map? json) {
    if (!json!.containsKey('token')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountEntity(token: json['token']);
  }

  AccountEntity toEntity() => AccountEntity(token: token);
}
