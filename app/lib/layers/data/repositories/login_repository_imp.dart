import 'package:app/layers/data/datasource/local/login_datasource_imp.dart';
import 'package:app/layers/domain/repositories/login_repository.dart';

class LoginRepositoryImp extends ILoginRepository {
  final LoginDatasourceImp _datasourceImp;
  LoginRepositoryImp(this._datasourceImp);

  @override
  Future<Map> login({required String user, required String password}) async {
    return await _datasourceImp.login(user: user, password: password);
  }
}
