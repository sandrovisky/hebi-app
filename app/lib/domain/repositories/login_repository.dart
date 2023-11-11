abstract class ILoginRepository {
  Future<Map> login({required String user, required String password});
}
