import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/providers/users_repository/users_repository_provider.dart';

final getUserByIdFutureProvider = FutureProvider.family<User?, String>((
  ref,
  username,
) async {
  final userRepo = ref.watch(usersRepositoryProvider);
  return userRepo.getUserById(username);
});

final searchUsersByIdFutureProvider = FutureProvider.family<List<User>, String>((
  ref,
  username,
) async {
  final userRepo = ref.watch(usersRepositoryProvider);
  return userRepo.searchUsersById(username);
});
