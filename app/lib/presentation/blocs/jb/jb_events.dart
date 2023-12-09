import 'package:hebi/domain/entities/entities.dart';

abstract class JbEvent {}

class GetShiftsJbEvent extends JbEvent {}

class ChangeSelectedShiftJbEvent extends JbEvent {
  final ShiftEntity shift;

  ChangeSelectedShiftJbEvent(this.shift);
}
