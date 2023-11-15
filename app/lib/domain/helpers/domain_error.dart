enum DomainError {
  unexpected,
  invalidCredentials,
}

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'USUARIO OU SENHA INVÁLIDOS.';
      default:
        return 'ALGO DEU ERRADO.';
    }
  }
}
