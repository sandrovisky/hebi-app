import 'package:flutter/material.dart';
import 'package:hebi/core/core.dart';
import 'package:hebi/data/cache/cache.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RedirectOn401Interceptor implements InterceptorContract {
  final ICacheStorage storage;

  RedirectOn401Interceptor(this.storage);

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      final context = NavigationService.navigatorKey.currentContext!;
      if (context.mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                      'Ação não concluída, sessão expirada. Refaça o Login.'),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login',
                        (route) => false,
                      );
                    },
                    child: const Text('Fechar'),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return data;
  }
}
