import 'dart:math';

import 'package:twitter_cosmos_db/domain/datasources/datasources.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/domain/preview_data/mock_data.dart';

class UsersDatasourceImpl implements UsersDatasource {
  @override
  Future<List<User>> getAllUsers() async {
    var rng = Random();
    int randomTime = rng.nextInt(500);
    return await Future.delayed(Duration(milliseconds: randomTime), () {
      return users;
    });
  }

  @override
  Future<User?> getUserById(String username) async {
    var rng = Random();
    int randomTime = rng.nextInt(200);
    return await Future.delayed(Duration(milliseconds: randomTime), () {
      final indexFound = users.indexWhere((u) {
        return u.username == username;
      });
      if (indexFound != -1) {
        return users[indexFound];
      }
      return null;
    });
  }

  @override
  Future<List<User>?> getFollwedByUserUsingId(String username) async {
    User? user = await getUserById(username);
    if (user == null) {
      return null;
    }
    final allUsers = await getAllUsers();
    final follwed = allUsers.where(
      (user) => user.followed.contains(user.username),
    );
    return follwed.toList();
  }
}
