enum Enviroments {
  DEVELOPMENT('http://localhost:7000/api/android', 'dev'),
  PRODUCTION('https://hebi.com.br/api/android', 'prod');

  final String url;
  final String mode;

  const Enviroments(this.url, this.mode);
}
