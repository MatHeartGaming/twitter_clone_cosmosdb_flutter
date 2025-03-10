import 'package:twitter_cosmos_db/domain/models/models.dart';

abstract class UsersRepository {
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(String username);
  Future<List<User>?> getFollwedByUserUsingId(String username);
}