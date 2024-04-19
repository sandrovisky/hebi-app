import 'package:bloc/bloc.dart';
import './/data/cache/cache.dart';
import './/domain/helpers/helpers.dart';
import './/domain/repositories/repositories.dart';

import './/domain/entities/entities.dart';

import './auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ICacheStorage storage;
  final IAuthRepository repository;

  AuthBloc({required this.storage, required this.repository})
      : super(LoadingAuthState()) {
    on<ChangeAccountAuthEvent>(_changeAccount);

    on<CheckSessionAuthEvent>(_validateToken);
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

  _validateToken(CheckSessionAuthEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await storage.fetch('user');

      if (user == null) return emit(LoggedOutAuthState());

      await repository.validateToken(AccountEntity.fromMap(user));
      accountEntity = AccountEntity.fromMap(user);
      emit(LoggedInAuthState());
    } on DomainError catch (error) {
      emit(ErrorAuthState(error));
    } catch (_) {
      await _logout(emit);
    }
  }

  _logout(Emitter<AuthState> emit) async {
    await storage.delete('user');
    emit(LoggedOutAuthState());
  }
}
