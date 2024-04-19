import './/domain/entities/entities.dart';

class OrderEntity {
  final List<ShiftEntity> shifts;
  final List<BetEntity> bets;

  OrderEntity({
    required this.shifts,
    required this.bets,
  });

  OrderEntity copyWith({
    List<ShiftEntity>? shifts,
    List<BetEntity>? bets,
  }) {
    return OrderEntity(
      shifts: shifts ?? this.shifts,
      bets: bets ?? this.bets,
    );
  }
}
