import './/domain/entities/entities.dart';

abstract class IShiftsRepository {
  Future<List<ShiftEntity>> getOpens();
}
