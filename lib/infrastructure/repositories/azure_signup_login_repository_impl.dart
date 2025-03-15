import 'package:twitter_cosmos_db/domain/datasources/datasources.dart';
import 'package:twitter_cosmos_db/domain/repositories/repositories.dart';
import 'package:twitter_cosmos_db/infrastructure/datasources/azure_signup_login_datasource_impl.dart';

class AzureSignupLoginRepositoryImpl implements SignupLoginRepository {
  final SignupLoginDatasource _db;

  AzureSignupLoginRepositoryImpl([SignupLoginDatasource? db])
    : _db = db ?? AzureSignupLoginDatasourceImpl();

  @override
  Future<bool> login() async {
    return _db.login();
  }

  @override
  Future<bool> signup() async {
    return _db.signup();
  }

  @override
  Future<bool> logout() {
    return _db.logout();
  }
}
