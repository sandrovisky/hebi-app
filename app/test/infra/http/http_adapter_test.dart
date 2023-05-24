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
    final jsonBody = body == null ? null : jsonEncode(body);
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    Response response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: jsonBody,
    );

    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}

void main() {
  group('post', () {
    final client = ClientSpy();
    final sut = HttpAdapter(client);
    final url = faker.internet.httpsUrl();

    mockCall() => when(
          () => client.post(
            Uri.parse(url),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          ),
        );

    mockWithResponse(Response response) =>
        mockCall().thenAnswer((_) async => response);

    setUp(
      () {
        mockWithResponse(Response('', 200));
      },
    );

    test('should call post with correct values', () async {
      await sut.request(
        url: url,
        method: 'post',
        body: {"any_key": "any_value"},
      );

      verify(
        () => client.post(
          Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}',
        ),
      );
    });
    test('should call post without body', () async {
      await sut.request(
        url: url,
        method: 'post',
      );

      verify(
        () => client.post(
          Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
        ),
      );
    });

    test('should return data if post return 200', () async {
      mockWithResponse(
        Response(jsonEncode({"any_key": "any_value"}), 200),
      );

      Map response = await sut.request(
        url: url,
        method: 'post',
      );

      expect(
        response,
        {"any_key": "any_value"},
      );
    });

    test('should return null if post return 200 with no data', () async {
      final response = await sut.request(
        url: url,
        method: 'post',
      );

      verify(() => client.post(Uri.parse(url)));
    });
  });
}
