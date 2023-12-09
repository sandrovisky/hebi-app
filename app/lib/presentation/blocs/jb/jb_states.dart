import 'package:hebi/domain/entities/entities.dart';

import './/domain/helpers/helpers.dart';

abstract class JBState {}

class InitialJBState extends JBState {}

class LoadingJBState extends JBState {}

class ErrorJBState extends JBState {
  final DomainError error;

  ErrorJBState(this.error);
}

class LoadedShiftJBState extends JBState {
  final List<ShiftEntity> shifts;

  LoadedShiftJBState(this.shifts);
}
