import 'package:app/core/navigator/navigator.dart';
import 'package:app/layers/domain/repositories/login_repository.dart';
import 'package:flutter/material.dart';

abstract class ILoginController extends ChangeNotifier {
  bool get isLoading;
  bool get hasError;
  String get error;

  Future<void> login();
  void clearError();
}

class LoginController extends ChangeNotifier implements ILoginController {
  final ILoginRepository repository;
  LoginController(
    this.repository,
  );

  bool _isLoading = false;
  String _error = '';

  void _setIsLoading({bool value = false}) {
    _isLoading = value;
    notifyListeners();
  }

  void _setIsError({String value = ''}) async {
    _error = value;
    await showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(_),
                child: const Text('Ok'),
              )
            ],
          );
        });
    notifyListeners();
  }

  @override
  String get error => _error;

  @override
  bool get hasError => _error.isNotEmpty;

  @override
  bool get isLoading => _isLoading;

  @override
  Future<void> login() async {
    try {
      _setIsLoading(value: true);
      Map result = await repository.login(user: '9998', password: '2706');
    } catch (e) {
      _setIsError(value: e.toString());
    } finally {
      _setIsLoading();
    }
  }

  @override
  void clearError() {
    _error = '';
    notifyListeners();
  }
}
