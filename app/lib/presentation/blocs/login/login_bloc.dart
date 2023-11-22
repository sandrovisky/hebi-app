import 'package:bloc/bloc.dart';
import 'package:hebi/data/cache/cache.dart';

import './/domain/helpers/helpers.dart';
import './/domain/usecases/usecases.dart';
import './/presentation/protocols/protocols.dart';
import './/ui/helpers/errors/errors.dart';

import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Authentication authentication;
  final ICacheStorage storage;
  final Validation validation;

  FormLoginState form = FormLoginState();

  LoginBloc({
    required this.authentication,
    required this.storage,
    required this.validation,
  }) : super(FormLoginState()) {
    on<PasswordChangeLoginEvent>(_passwordEvent);

    on<UserChangeLoginEvent>(_userEvent);

    on<AuthLoginEvent>(_authEvent);

    on<ClearErrorLoginEvent>(_clearError);
  }

  void _passwordEvent(
      PasswordChangeLoginEvent event, Emitter<LoginState> emit) {
    form = form.copyWith(password: event.password);
    form = form.copyWith(passwordError: _validateField('password'));
    form = form.copyWith(isFormValid: _validateForm());

    emit(form);
  }

  void _userEvent(UserChangeLoginEvent event, Emitter<LoginState> emit) {
    form = form.copyWith(user: event.user);
    form = form.copyWith(userError: _validateField('user'));
    form = form.copyWith(isFormValid: _validateForm());

    emit(form);
  }

  void _authEvent(AuthLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoadingLoginState());
      final params = AuthenticationParams(
        user: form.user,
        password: form.password,
      );
      final user = await authentication.auth(params);
      await storage.save(key: 'user', value: user.toMap());
      emit(SuccessLoginState(user));
      form = FormLoginState();
      emit(form);
    } on DomainError catch (e) {
      form = form.copyWith(password: '');
      emit(ErrorLoginState(e.description));
    } catch (e) {
      form = form.copyWith(password: '');
      emit(ErrorLoginState(e.toString()));
    }
  }

  void _clearError(ClearErrorLoginEvent event, Emitter<LoginState> emit) {
    emit(form);
  }

  UIError? _validateField(String field) {
    final error = validation.validate(
      field: field,
      input: form.mapToValidate(),
    );

    switch (error) {
      case ValidationError.onlyNumbers:
        return UIError.onlyNumberField;
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return UIError.noError;
    }
  }

  bool _validateForm() {
    return form.userError == null &&
        form.passwordError == null &&
        form.user.isNotEmpty &&
        form.password.isNotEmpty;
  }
}
