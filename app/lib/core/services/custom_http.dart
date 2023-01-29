import 'dart:convert';

import 'package:http/http.dart' as http;

class CustomHTTP {
  CustomHTTP(
    this.baseURL,
  );
  final String? baseURL;

  Future<Map> get({required String endpoint}) async {
    Uri url = Uri.parse('$baseURL/$endpoint/');
    http.Response response;

    response = await http.get(url).then((value) {
      print(value.body);
      print(value.statusCode);
      return value;
    });

    return {};
  }

  Future<Map> post(
      {required String endpoint, required Map<String, dynamic> body}) async {
    Uri url = Uri.parse('$baseURL/$endpoint/');
    http.Response response;

    print(url);
    print(body);

    response = await http.post(url, body: jsonEncode(body)).then((value) {
      print(value.statusCode);
      print(value.body);
      return value;
    });
    return {};
  }
}
