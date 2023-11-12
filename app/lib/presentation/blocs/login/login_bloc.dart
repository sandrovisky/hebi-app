import 'package:bloc/bloc.dart';
import 'package:hebi/ui/helpers/errors/errors.dart';

import './/domain/usecases/usecases.dart';
import './/presentation/protocols/protocols.dart';

import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Authentication authentication;
  final Validation validation;

  FormLoginState form = FormLoginState();

  LoginBloc({
    required this.authentication,
    required this.validation,
  }) : super(FormLoginState()) {
    on<PasswordChangeLoginEvent>(_passwordEvent);

    on<UserChangeLoginEvent>(_userEvent);

    on<AuthLoginEvent>(_authEvent);

    on<ClearErrorLoginEvent>(_clearError);
  }

  _passwordEvent(PasswordChangeLoginEvent event, Emitter<LoginState> emit) {
    form = form.copyWith(password: event.password);
    emit(form.copyWith(
      passwordError: _validateField('password'),
      isFormValid: _validateForm(),
    ));
  }

  _userEvent(UserChangeLoginEvent event, Emitter<LoginState> emit) {
    form = form.copyWith(user: event.user);
    emit(form.copyWith(
      userError: _validateField('user'),
      isFormValid: _validateForm(),
    ));
  }

  _authEvent(AuthLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginState());
    final params = AuthenticationParams(
      user: form.user,
      password: form.password,
    );
    await authentication.auth(params);
    emit(form);
  }

  _clearError(ClearErrorLoginEvent event, Emitter<LoginState> emit) {
    emit(form);
  }

  UIError? _validateField(String field) {
    final formData = {
      'user': form.user,
      'password': form.password,
    };
    print(formData);
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.onlyNumbers:
        return UIError.onlyNumberField;
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  bool _validateForm() {
    return form.userError == null &&
        form.passwordError == null &&
        form.user.isNotEmpty &&
        form.password.isNotEmpty;
  }
}
