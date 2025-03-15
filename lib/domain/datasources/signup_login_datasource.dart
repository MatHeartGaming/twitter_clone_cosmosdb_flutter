abstract class SignupLoginDatasource {
  Future<bool> login();
  Future<bool> signup();
  Future<bool> logout();
}
