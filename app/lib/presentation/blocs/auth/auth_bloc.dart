import 'package:bloc/bloc.dart';
import 'package:hebi/data/cache/cache.dart';
import 'package:hebi/domain/repositories/repositories.dart';

import './/domain/entities/entities.dart';

import './auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ICacheStorage storage;
  final IAuthRepository repository;

  AuthBloc({required this.storage, required this.repository})
      : super(LoadingAuthState()) {
    on<ChangeAccountAuthEvent>(_changeAccount);

    on<CheckAccountAuthEvent>(_checkAccount);
  }

  AccountEntity? accountEntity;

  _changeAccount(ChangeAccountAuthEvent event, Emitter<AuthState> emit) async {
    if (event.accountEntity == null) {
      await _logout(emit);
    } else {
      accountEntity = event.accountEntity;
      emit(LoggedInAuthState());
    }
  }

  _checkAccount(CheckAccountAuthEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await storage.fetch('user');
      if (user != null) {
        await _logout(emit);
      } else {
        await repository.checkUser(AccountEntity.fromMap(user));
        accountEntity = AccountEntity.fromMap(user);
        emit(LoggedInAuthState());
      }
    } catch (e) {
      await _logout(emit);
    }
  }

  _logout(Emitter<AuthState> emit) async {
    await storage.delete('user');
    emit(LoggedOutAuthState());
  }
}
