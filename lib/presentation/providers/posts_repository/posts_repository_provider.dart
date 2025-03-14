import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/repositories/posts_repository.dart';
import 'package:twitter_cosmos_db/infrastructure/datasources/datasources.dart';
import 'package:twitter_cosmos_db/infrastructure/repositories/repositories.dart';

final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  return PostsRepositoryImpl(PostsCosmosdbDatasourceImpl());
});
