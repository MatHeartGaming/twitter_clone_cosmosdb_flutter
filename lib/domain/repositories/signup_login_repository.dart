abstract class SignupLoginRepository {
  Future<bool> login();
  Future<bool> signup();
  Future<bool> logout();
}
