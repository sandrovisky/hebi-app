import 'package:bloc/bloc.dart';

import 'settings.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(InitialSettingsState()) {
    on<ClearErrorSettingsEvent>(_clearError);
  }

  void _clearError(ClearErrorSettingsEvent event, Emitter<SettingsState> emit) {
    emit(InitialSettingsState());
  }
}
