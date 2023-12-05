import './/domain/helpers/helpers.dart';

sealed class SettingsState {}

class InitialSettingsState extends SettingsState {}

class LoadingSettingsState extends SettingsState {}

class ErrorSettingsState extends SettingsState {
  final DomainError error;

  ErrorSettingsState(this.error);
}
