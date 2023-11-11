abstract class ILoginRepository {
  final String? apiURL;

  ILoginRepository(this.apiURL);

  Future<Map> login({required String user, required String password});
}
