import 'package:bloc/bloc.dart';

import 'package:app/blocs/login/events.dart';
import 'package:app/blocs/login/states.dart';
import 'package:app/data/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ILoginRepository _loginRepository;

  FormLoginState form = FormLoginState();

  LoginBloc(this._loginRepository) : super(InitialLoginState()) {
    on<PasswordChangeLoginEvent>(_passwordEvent);

    on<UserChangeLoginEvent>(_userEvent);

    on<AuthLoginEvent>(_authEvent);
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
    emit(SuccessLoginState());
  }
}
