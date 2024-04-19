import './/domain/entities/entities.dart';

abstract class ICreateJb {
  Future<List<ShiftEntity>> getOpenShifts();
  Future<List<ModalityEntity>> fetchGames();
}
