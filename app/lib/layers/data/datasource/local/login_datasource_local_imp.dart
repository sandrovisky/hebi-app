import 'package:app/core/services/custom_http.dart';
import 'package:app/layers/data/datasource/login_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDatasourceLocalImp extends ILoginDatasource {
  LoginDatasourceLocalImp(super.apiURL);

  @override
  Future<Map> login({required String user, required String password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? device = prefs.getString('device_info');
    Map<String, dynamic> body = {
      'user': user,
      'password': password,
      'device_id': '$device/$user'
    };

    await CustomHTTP(apiURL).post(endpoint: 'login', body: body);
    return {};
  }
}
