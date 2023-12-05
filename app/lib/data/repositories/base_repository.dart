import './/data/http/http.dart';
import './/domain/helpers/helpers.dart';

abstract class BaseRepository {
  DomainError handle401Error(Http401Error error) {
    switch (error.code) {
      case 'user-locked':
        return DomainError.userLocked;
      case 'token-expired':
        return DomainError.tokenExpired;
      case 'token-unexpected-error':
        return DomainError.tokenUnexpectedError;
      case 'invalid-credentials':
        return DomainError.invalidCredentials;
      default:
        return DomainError.unexpected;
    }
  }
}
