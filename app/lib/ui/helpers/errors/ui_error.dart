enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  onlyNumberField
}

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo Obrigatório.';
      case UIError.invalidField:
        return 'Campo Inválido.';
      case UIError.invalidCredentials:
        return 'Verifique usuário e senha.';
      case UIError.onlyNumberField:
        return 'Deve conter apenas números.';
      case UIError.unexpected:
        return 'Erro Inesperado';
      default:
        return 'Erro Inesperado';
    }
  }
}
