enum HttpError {
  badRequest,
  notFound,
  serverError,
  unauthorized,
  invalidData,
  forbidden,
  socketError
}

class Http401Error {
  final String code;

  Http401Error(this.code);
}
