enum DomainError {
  unexpected('Erro inesperado.', false),
  invalidCredentials('Verifique usuário e senha.', false),
  userLocked('Usuário bloqueado.', true),
  tokenExpired('Token Expirado.', true),
  tokenUnexpectedError('Falha na autenticação.', true),
  socketAdapterError('Verifique a conexão e tente novamente.', false);

  final String description;
  final bool shouldRedirect;

  const DomainError(this.description, this.shouldRedirect);
}
