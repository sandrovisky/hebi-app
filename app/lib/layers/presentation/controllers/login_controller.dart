// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/layers/domain/repositories/login_repository.dart';
import 'package:flutter/material.dart';

abstract class ILoginController extends ChangeNotifier {
  bool get isLoading;
  bool get hasError;
  String get error;

  Future<Map> login({required String user, required String password});
}

class LoginController extends ChangeNotifier implements ILoginController {
  final ILoginRepository repository;
  LoginController(
    this.repository,
    this.onError,
  );

  bool _isLoading = false;
  String _error = '';

  final Future<void> Function(String) onError;

  _setIsLoading({bool value = false}) {
    _isLoading = value;
    notifyListeners();
  }

  _setIsError({String value = ''}) {
    _error = value;
    onError(value);
    notifyListeners();
  }

  @override
  String get error => _error;

  @override
  bool get hasError => _error.isNotEmpty;

  @override
  bool get isLoading => _isLoading;

  @override
  Future<Map> login({required String user, required String password}) async {
    try {
      _setIsLoading(value: true);
      Map result = await repository.login(user: user, password: password);

      return result;
    } catch (e) {
      _setIsError(value: e.toString());
      return {};
    } finally {
      _setIsLoading();
    }
  }
}
