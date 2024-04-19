import 'package:flutter/foundation.dart';
import './/domain/entities/entities.dart';
import './/domain/usecases/create_jb.dart';

import './/domain/repositories/repositories.dart';

class RemoteCreateJb implements ICreateJb {
  final ICreateJbRepository repository;

  RemoteCreateJb({required this.repository});

  @override
  Future<List<ShiftEntity>> getOpenShifts() async {
    try {
      return await repository.getOpens();
    } catch (error) {
      debugPrint('RemoteCreateJb: $error');
      rethrow;
    }
  }

  @override
  Future<List<ModalityEntity>> fetchGames() async {
    try {
      return await repository.fetchGames();
    } catch (error) {
      debugPrint('RemoteCreateJb: $error');
      rethrow;
    }
  }
}
