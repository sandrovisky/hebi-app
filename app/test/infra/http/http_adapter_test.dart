import 'dart:convert';

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
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(Uri.parse(url), headers: headers, body: jsonEncode(body));

    return {};
  }
}

void main() {
  group('post', () {
    final client = ClientSpy();
    final sut = HttpAdapter(client);
    final url = faker.internet.httpsUrl();
    test('should call post with correct values', () async {
      when(() => client.post(Uri.parse(url), headers: any(named: 'headers')))
          .thenAnswer((_) async => Response('', 200));

      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(
        () => client.post(
          Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: "{'any_key': 'any_value'}",
        ),
      );
    });
  });
}
