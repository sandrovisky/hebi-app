import 'package:app/layers/data/datasource/login_datasource.dart';

class LoginDatasourceImp extends ILoginDatasource {
  @override
  Future<Map> login({required String user, required String password}) async {
    await Future.delayed(const Duration(seconds: 3));

    if (user == 'adm' && password == 'adm') {
      return {};
    }
    throw Exception('falha login');
  }
}
