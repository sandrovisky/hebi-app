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

  setUp(
    () {},
  );

  test('should call HttpCliente with correct values', () async {
    final params = AuthenticationParams(
        user: faker.person.firstName(), password: faker.internet.password());
    await sut.auth(params);

    verify(
      () => httpClient.request(url: url, method: 'post', body: {
        'user': params.user,
        'password': params.password,
      }),
    );
  });

  test('should throw UnexpectedError if HttpClient return 400', () async {
    when(
      () async => await httpClient.request(
        url: any(named: 'url'),
        method: any(named: 'method'),
        body: any(named: 'body'),
      ),
    ).thenThrow(HttpError.badRequest);

    final params = AuthenticationParams(
        user: faker.person.firstName(), password: faker.internet.password());
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
