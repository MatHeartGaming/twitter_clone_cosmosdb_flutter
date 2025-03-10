import 'package:twitter_cosmos_db/domain/models/post.dart';
import 'package:twitter_cosmos_db/domain/repositories/repositories.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRepository _db;

  PostsRepositoryImpl([PostsRepository? db])
    : _db = db ?? PostsRepositoryImpl();

  @override
  Future<List<Post>> getAllPosts() {
    return _db.getAllPosts();
  }

  @override
  Future<List<Post>> getPostsByUserName(String username) {
    return _db.getPostsByUserName(username);
  }
}
