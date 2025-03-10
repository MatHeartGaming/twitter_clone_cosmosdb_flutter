import 'package:twitter_cosmos_db/domain/datasources/datasources.dart';
import 'package:twitter_cosmos_db/domain/models/post.dart';
import 'package:twitter_cosmos_db/domain/repositories/repositories.dart';
import 'package:twitter_cosmos_db/infrastructure/datasources/posts_datasource_impl.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsDatasource _db;

  PostsRepositoryImpl([PostsDatasource? db])
    : _db = db ?? PostsDatasourceImpl();

  @override
  Future<List<Post>> getAllPosts() {
    return _db.getAllPosts();
  }

  @override
  Future<List<Post>> getPostsByUserName(String username) {
    return _db.getPostsByUserName(username);
  }

  @override
  Future<Post?> updatePost(Post post) {
    return _db.updatePost(post);
  }
}
