// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/domain/repositories/repositories.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';

final loadPostsProvider =
    StateNotifierProvider<AllPostsNotifier, AllPostsState>((ref) {
      final postRepository = ref.watch(postsRepositoryProvider);
      //final singedInUser = ref.watch(signed);
      final allPostsNotifier = AllPostsNotifier(postRepository);
      return allPostsNotifier;
    });

class AllPostsNotifier extends StateNotifier<AllPostsState> {
  final PostsRepository _postsRepository;

  AllPostsNotifier(PostsRepository postsRepository)
    : _postsRepository = postsRepository, // Initialize _postsRepository here
      super(AllPostsState(allPosts: [], allSignedInUserPosts: []));

  Future<List<Post>> fetchAllPosts() async {
    if (state.isLoading) return state.allPosts;
    state = state.copyWith(isLoading: true);
    final posts = await _postsRepository.getAllPosts();
    state = state.copyWith(allPosts: posts, isLoading: false);
    return state.allPosts;
  }

  Future<List<Post>> fetchAllSignedInuserPosts({
    String username = 'MatBuompy',
  }) async {
    if (state.isLoading) return state.allSignedInUserPosts;
    state = state.copyWith(isLoading: true);
    final posts = await _postsRepository.getPostsByUserName(username);
    state = state.copyWith(allSignedInUserPosts: posts, isLoading: false);
    return state.allSignedInUserPosts;
  }

  Future<Post?> updatePost(Post post) async {
    final updatedPost = await _postsRepository.updatePost(post);
    return updatedPost;
  }
}

class AllPostsState {
  final bool isLoading;
  final List<Post> allPosts;
  final List<Post> allSignedInUserPosts;

  AllPostsState({
    this.isLoading = false,
    required this.allPosts,
    required this.allSignedInUserPosts,
  });

  @override
  bool operator ==(covariant AllPostsState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading &&
        listEquals(other.allPosts, allPosts) &&
        listEquals(other.allSignedInUserPosts, allSignedInUserPosts);
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^ allPosts.hashCode ^ allSignedInUserPosts.hashCode;

  AllPostsState copyWith({
    bool? isLoading,
    List<Post>? allPosts,
    List<Post>? allSignedInUserPosts,
  }) {
    return AllPostsState(
      isLoading: isLoading ?? this.isLoading,
      allPosts: allPosts ?? this.allPosts,
      allSignedInUserPosts: allSignedInUserPosts ?? this.allSignedInUserPosts,
    );
  }
}
