abstract class ILoginDatasource {
  Future<Map> login({required String user, required String password});
}
