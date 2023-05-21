import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:app/layers/domain/helpers/helpers.dart';
import 'package:app/layers/domain/usecases/usecases.dart';

import 'package:app/layers/data/http/http.dart';
import 'package:app/layers/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  final httpClient = HttpClientSpy();
  final url = faker.internet.httpUrl();
  final sut = RemoteAuthentication(httpClient: httpClient, url: url);
  final params = AuthenticationParams(
      user: faker.person.firstName(), password: faker.internet.password());

  mockRequest() => when(
        () async => await httpClient.request(
          url: any(named: 'url'),
          method: any(named: 'method'),
          body: any(named: 'body'),
        ),
      );

  mockHttpData(Map data) => mockRequest().thenAnswer((_) async => data);

  mockHttpError(HttpError error) => mockRequest().thenThrow(error);

  test('should call HttpCliente with correct values', () async {
    final accessToken = faker.guid.guid();
    mockHttpData({'token': accessToken});

    await sut.auth(params: params);

    verify(
      () => httpClient.request(url: url, method: 'post', body: {
        'user': params.user,
        'password': params.password,
      }),
    );
  });

  test('should throw UnexpectedError if HttpClient return 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient return 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw UnexpectedError if HttpClient return 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('should throw InvalidCredentialsError if HttpClient return 401',
      () async {
    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('should return an Account if HttpClient return 200', () async {
    final accessToken = faker.guid.guid();
    mockHttpData({'token': accessToken});

    final account = await sut.auth(params: params);

    expect(account!.token, accessToken);
  });

  test('should throw UnexpectedError if HttpClient return 200 with invalid',
      () async {
    mockHttpData({'invalid_key': 'invalid_value'});

    final future = sut.auth(params: params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
