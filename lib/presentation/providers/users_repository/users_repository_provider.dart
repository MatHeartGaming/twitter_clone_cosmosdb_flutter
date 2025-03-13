import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/repositories/users_repository.dart';
import 'package:twitter_cosmos_db/infrastructure/datasources/users_cosmosdb_impl.dart';
import 'package:twitter_cosmos_db/infrastructure/repositories/repositories.dart';

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepositoryImpl(UsersCosmosdbImpl());
});