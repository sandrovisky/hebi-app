import 'package:http/http.dart';
import 'dart:convert';

import './/data/cache/cache.dart';
import './/data/http/http.dart';

class InterceptedHttpAdapter implements IHttpClient {
  final Client client;
  final ICacheStorage storage;

  InterceptedHttpAdapter({required this.client, required this.storage});

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    final user = (await storage.fetch('user'));
    final defaultHeaders = headers?.cast<String, String>() ?? {};
    if (user != null) {
      defaultHeaders.addAll(
        {
          'content-type': 'application/json',
          'accept': 'application/json',
          'Authorization': 'Bearer ${user["token"]}',
          'app': 'true',
          'Logged': user['logged'],
          'Customer': user['customer'],
          'Salesman': user['salesman'],
        },
      );
    }
    final jsonBody = body != null ? jsonEncode(body) : null;
    Response response = Response('', 500);
    try {
      if (method == 'post') {
        response = await client.post(
          Uri.parse(url),
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else if (method == 'get') {
        response = await client.get(Uri.parse(url), headers: defaultHeaders);
      } else if (method == 'put') {
        response = await client.put(
          Uri.parse(url),
          headers: defaultHeaders,
          body: jsonBody,
        );
      }
    } catch (error) {
      throw HttpError.serverError;
    }
    return await _handleResponse(response);
  }

  Future<dynamic> _handleResponse(Response response) async {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
