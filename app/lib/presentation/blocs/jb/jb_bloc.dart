import 'package:bloc/bloc.dart';

import './/domain/entities/entities.dart';
import './/domain/helpers/helpers.dart';
import './/domain/usecases/usecases.dart';

import './jb.dart';

class JBBloc extends Bloc<JbEvent, JBState> {
  final ICreateJb useCase;

  JBBloc({required this.useCase}) : super(InitialJBState()) {
    on<GetShiftsJbEvent>(_getShifts);

    on<ChangeSelectedShiftJbEvent>(_changeSelectedShift);
  }

  List<ShiftEntity> _shifts = [];

  void _getShifts(GetShiftsJbEvent event, Emitter<JBState> emit) async {
    emit(LoadingJBState());
    try {
      _shifts = await useCase.getOpenShifts();
      emit(LoadedShiftJBState(_shifts));
    } on DomainError catch (error) {
      emit(ErrorJBState(error));
    } catch (_) {
      emit(ErrorJBState(DomainError.unexpected));
    }
  }

  void _changeSelectedShift(
    ChangeSelectedShiftJbEvent event,
    Emitter<JBState> emit,
  ) async {
    for (var shift in _shifts) {
      if (shift.number == event.shift.number) {
        shift.isSelected = !shift.isSelected;
      }
    }

    emit(LoadedShiftJBState(_shifts));
  }
}
