// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/layers/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void>? auth(AuthenticationParams params) async {
    final body = {'user': params.user, 'password': params.password};
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient {
  Future<void>? request(
      {required String url, required String method, Map? body});
}

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
}
