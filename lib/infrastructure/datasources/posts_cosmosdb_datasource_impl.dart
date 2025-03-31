import 'package:azure_cosmosdb/azure_cosmosdb.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/constants/environment.dart';
import 'package:twitter_cosmos_db/domain/datasources/datasources.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';

class PostsCosmosdbDatasourceImpl implements PostsDatasource {
  final _cosmosDB = CosmosDbServer(
    'https://matsub.documents.azure.com:443/',
    masterKey: Environment.comosDBMasterKey,
  );

  @override
  Future<List<Post>> getAllPosts() async {
    final database = await _cosmosDB.databases.openOrCreate('twitter_db');

    final postsCollection = await database.containers.openOrCreate(
      'Posts',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    postsCollection.registerBuilder(Post.fromJson);

    final allPosts = await postsCollection.query<Post>(
      Query('SELECT * FROM c'),
    );

    return allPosts.toList();
  }

  @override
  Future<List<Post>> getPostsByUserName(String username) async {
    final database = await _cosmosDB.databases.open('twitter_db');

    final postsCollection = await database.containers.openOrCreate(
      'Posts',
      partitionKey: PartitionKeySpec.id,
    );

    postsCollection.registerBuilder(Post.fromJson);

    final postsByUserid = await postsCollection.query<Post>(
      Query(
        'SELECT * FROM c WHERE c.userId = @username',
        params: {'@username': username},
      ),
    );

    return postsByUserid.toList();
  }

  @override
  Future<Post?> getPostById(String postId) async {
    final database = await _cosmosDB.databases.open('twitter_db');

    final postsCollection = await database.containers.openOrCreate(
      'Posts',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    postsCollection.registerBuilder(Post.fromJson);

    final postQueryResult = await postsCollection.query<Post>(
      Query(
        'SELECT * FROM c WHERE c.id = @postId',
        params: {'@postId': postId},
      ),
    );

    final posts = postQueryResult.toList();

    // Return the first post if it exists, otherwise return null
    return posts.isNotEmpty ? posts.first : null;
  }

// https://new-twitter-clone-function.azurewebsites.net/api/likepostfunction
  @override
  Future<Post?> createPost(Post post) async {
    final database = await _cosmosDB.databases.open('twitter_db');

    final postsCollection = await database.containers.openOrCreate(
      'Posts',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    postsCollection.registerBuilder(Post.fromJson);

    final postToInsert = await postsCollection.add(post);

    logger.i('Users prova: $postsCollection');

    return postToInsert;
  }

  @override
  Future<Post?> updatePost(Post post) async {
    final database = await _cosmosDB.databases.open('twitter_db');

    final postsCollection = await database.containers.openOrCreate(
      'Posts',
      partitionKey: PartitionKeySpec.id,
      //indexingPolicy: indexingPolicy,
    );

    postsCollection.registerBuilder(Post.fromJson);
    logger.i('Post to update: ${post.toJson()}');

    final postToUpdate = await postsCollection.upsert(post);

    logger.i('User to update: $postToUpdate');

    return postToUpdate;
  }
}
