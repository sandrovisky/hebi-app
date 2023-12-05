enum UIError {
  requiredField('Campo Obrigatório.'),
  invalidField('Campo Inválido.'),
  unexpected('Erro Inesperado'),
  invalidCredentials('Verifique usuário e senha.'),
  onlyNumberField('Deve conter apenas números.'),
  noError('');

  final String description;

  const UIError(this.description);
}
