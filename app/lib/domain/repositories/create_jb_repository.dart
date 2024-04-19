import './/domain/entities/entities.dart';

abstract class ICreateJbRepository {
  Future<List<ShiftEntity>> getOpens();
  Future<List<ModalityEntity>> fetchGames();
}
