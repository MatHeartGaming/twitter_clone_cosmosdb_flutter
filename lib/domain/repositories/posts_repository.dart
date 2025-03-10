import 'package:twitter_cosmos_db/domain/models/models.dart';

abstract class PostsRepository {
  Future<List<Post>> getAllPosts();
  Future<List<Post>> getPostsByUserName(String username);
  Future<Post?> updatePost(Post post);
}