import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientSpy extends Mock implements Client {}

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future? request({
    required String url,
    required String method,
    Map? body,
  }) async {
    await client.post(Uri.parse(url));

    return {};
  }
}

void main() {
  group('post', () {
    test('should call post with correct values', () async {
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpsUrl();

      when(() => client.post(Uri.parse(url)))
          .thenAnswer((_) async => Response('', 200));

      await sut.request(url: url, method: 'post');

      verify(() => client.post(Uri.parse(url)));
    });
  });
}
