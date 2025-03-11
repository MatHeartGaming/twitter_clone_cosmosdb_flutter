import 'package:twitter_cosmos_db/domain/models/models.dart';

abstract class UsersDatasource {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String username);
  Future<List<User>?> getFollwedByUserUsingId(String username);
  Future<User?> updateUser(User user);
  Future<List<User?>> searchUsersById(String username);
  Future<User?> createNewUser(User user);
}
