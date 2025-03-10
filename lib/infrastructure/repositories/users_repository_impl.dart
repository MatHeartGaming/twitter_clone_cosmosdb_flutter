import 'package:twitter_cosmos_db/domain/models/user.dart';
import 'package:twitter_cosmos_db/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRepository _db;

  UsersRepositoryImpl([UsersRepository? db])
    : _db = db ?? UsersRepositoryImpl();

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
}
