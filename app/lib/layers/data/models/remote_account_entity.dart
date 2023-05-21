import 'package:app/layers/domain/entities/entities.dart';

class RemoteAccountEntity {
  final String token;

  RemoteAccountEntity({required this.token});

  factory RemoteAccountEntity.fromJson(Map? json) =>
      RemoteAccountEntity(token: json!['token']);

  AccountEntity toEntity() => AccountEntity(token: token);
}
