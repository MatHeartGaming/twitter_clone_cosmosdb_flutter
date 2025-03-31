import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/models/post.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/domain/repositories/posts_repository.dart';

final postProvider = StateNotifierProvider.family<PostNotifier, Post, String>(
  (ref, postId) {
    final postsRepository = ref.watch(postsRepositoryProvider);
    return PostNotifier(postsRepository, postId);
  },
);

class PostNotifier extends StateNotifier<Post> {
  final PostsRepository _postsRepository;
  final String _postId;

  PostNotifier(this._postsRepository, this._postId) : super(Post.empty()) {
    _loadPost();
  }

  Future<void> _loadPost() async {
    final post = await _postsRepository.getPostById(_postId);
    if (post != null) {
      state = post;
    }
  }

  Future<void> addComment(String comment) async {
    final updatedComments = [...state.comments, comment];
    final updatedPost = state.copyWith(comments: updatedComments);

    // Save the updated post to the database
    await _postsRepository.updatePost(updatedPost);

    // Update the state
    state = updatedPost;
  }
}
