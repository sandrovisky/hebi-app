import 'package:app/core/services/custom_http.dart';
import 'package:app/layers/data/datasource/login_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDatasourceRemoteImp extends ILoginDatasource {
  LoginDatasourceRemoteImp(super.apiURL);

  @override
  Future<Map> login({required String user, required String password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      'user': user,
      'password': password,
      'device_info': prefs.getString('device_info')
    };

    await CustomHTTP(apiURL).post(endpoint: 'login', body: body);
    return {};
  }
}
