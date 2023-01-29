abstract class ILoginDatasource {
  final String? apiURL;

  ILoginDatasource(this.apiURL);
  Future<Map> login({required String user, required String password});
}
