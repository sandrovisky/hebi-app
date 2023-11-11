import 'package:bloc/bloc.dart';

import './/presentation/blocs/login/events.dart';
import './/presentation/blocs/login/states.dart';
import './/data/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //final ILoginRepository _loginRepository;

  FormLoginState form = FormLoginState();

  LoginBloc() : super(FormLoginState()) {
    on<PasswordChangeLoginEvent>(_passwordEvent);

    on<UserChangeLoginEvent>(_userEvent);

    on<AuthLoginEvent>(_authEvent);

    on<ClearErrorLoginEvent>(_clearError);
  }

  _passwordEvent(PasswordChangeLoginEvent event, Emitter<LoginState> emit) {
    emit(form.copyWith(password: event.password));
  }

  _userEvent(UserChangeLoginEvent event, Emitter<LoginState> emit) {
    emit(form.copyWith(user: event.user));
  }

  _authEvent(AuthLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginState());
    await Future.delayed(const Duration(seconds: 2));
    emit(form);
  }

  _clearError(ClearErrorLoginEvent event, Emitter<LoginState> emit) {
    emit(form);
  }
}
