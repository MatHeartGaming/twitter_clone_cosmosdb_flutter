import 'dart:math';

import 'package:twitter_cosmos_db/domain/datasources/datasources.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/domain/preview_data/mock_data.dart';

class PostsDatasourceImpl implements PostsDatasource {
  @override
  Future<List<Post>> getAllPosts() async {
    var rng = Random();
    int randomTime = rng.nextInt(500);
    return await Future.delayed(
      Duration(milliseconds: randomTime),
      () => tweets,
    );
  }

  @override
  Future<List<Post>> getPostsByUserName(String username) async {
    var rng = Random();
    int randomTime = rng.nextInt(300);
    return await Future.delayed(
      Duration(milliseconds: randomTime),
      () => tweets.where((element) => element.userId == username).toList(),
    );
  }

  @override
  Future<Post?> updatePost(Post post) async {
    var rng = Random();
    int randomTime = rng.nextInt(300);

    return await Future.delayed(Duration(milliseconds: randomTime), () {
      final indexFound = tweets.indexWhere((p) => p.id == post.id);
      if (indexFound != -1) {
        tweets[indexFound] = post;
        return post;
      }
      return null;
    });
  }
}
