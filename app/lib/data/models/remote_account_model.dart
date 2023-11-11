import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteAccountModel {
  final String token;

  RemoteAccountModel({required this.token});

  factory RemoteAccountModel.fromJson(Map? json) {
    if (!json!.containsKey('token')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(token: json['token']);
  }

  AccountEntity toEntity() => AccountEntity(token: token);
}
