import 'package:twitter_cosmos_db/domain/datasources/datasources.dart';
import 'package:twitter_cosmos_db/domain/models/user.dart';
import 'package:twitter_cosmos_db/domain/repositories/users_repository.dart';
import 'package:twitter_cosmos_db/infrastructure/datasources/users_datasource_impl.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersDatasource _db;

  UsersRepositoryImpl([UsersDatasource? db])
    : _db = db ?? UsersDatasourceImpl();

  @override
  Future<List<User>> getAllUsers() {
    return _db.getAllUsers();
  }

  @override
  Future<List<User>?> getFollwedByUserUsingId(String username) {
    return _db.getFollwedByUserUsingId(username);
  }

  @override
  Future<User?> getUserById(String username) {
    return _db.getUserById(username);
  }

  @override
  Future<User?> updateUser(User user) {
    return _db.updateUser(user);
  }

  @override
  Future<User?> createNewUser(User user) {
    return _db.createNewUser(user);
  }

  @override
  Future<List<User?>> searchUsersById(String username) {
    return _db.searchUsersById(username);
  }
}
