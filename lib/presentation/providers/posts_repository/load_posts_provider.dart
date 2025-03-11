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
    if (state.isLoadingAllPosts) return state.allPosts;
    state = state.copyWith(isLoadingAllPosts: true);
    final posts = await _postsRepository.getAllPosts();
    state = state.copyWith(allPosts: posts, isLoadingAllPosts: false);
    return state.allPosts;
  }

  Future<List<Post>> fetchAllSignedInuserPosts({
    String username = 'MatBuompy',
  }) async {
    if (state.isLoadingSignedInUserPosts) return state.allSignedInUserPosts;
    state = state.copyWith(isLoadingSignedInUserPosts: true);
    final posts = await _postsRepository.getPostsByUserName(username);
    state = state.copyWith(
      allSignedInUserPosts: posts,
      isLoadingSignedInUserPosts: false,
    );
    return state.allSignedInUserPosts;
  }

  Future<Post?> updatePost(Post post) async {
    final updatedPost = await _postsRepository.updatePost(post);
    return updatedPost;
  }

  Future<Post?> addPost(Post post) async {
    final addedPost = await _postsRepository.createPost(post);
    if (addedPost != null) {
      state = state.copyWith(
        allPosts: [...state.allPosts, addedPost],
        allSignedInUserPosts: [...state.allSignedInUserPosts, addedPost],
      );
    }
    return addedPost;
  }
}

class AllPostsState {
  final bool isLoadingAllPosts;
  final bool isLoadingSignedInUserPosts;
  final List<Post> allPosts;
  final List<Post> allSignedInUserPosts;

  AllPostsState({
    this.isLoadingAllPosts = false,
    this.isLoadingSignedInUserPosts = false,
    required this.allPosts,
    required this.allSignedInUserPosts,
  });

  @override
  bool operator ==(covariant AllPostsState other) {
    if (identical(this, other)) return true;

    return other.isLoadingAllPosts == isLoadingAllPosts &&
        other.isLoadingSignedInUserPosts == isLoadingSignedInUserPosts &&
        listEquals(other.allPosts, allPosts) &&
        listEquals(other.allSignedInUserPosts, allSignedInUserPosts);
  }

  @override
  int get hashCode {
    return isLoadingAllPosts.hashCode ^
        isLoadingSignedInUserPosts.hashCode ^
        allPosts.hashCode ^
        allSignedInUserPosts.hashCode;
  }

  AllPostsState copyWith({
    bool? isLoadingAllPosts,
    bool? isLoadingSignedInUserPosts,
    List<Post>? allPosts,
    List<Post>? allSignedInUserPosts,
  }) {
    return AllPostsState(
      isLoadingAllPosts: isLoadingAllPosts ?? this.isLoadingAllPosts,
      isLoadingSignedInUserPosts:
          isLoadingSignedInUserPosts ?? this.isLoadingSignedInUserPosts,
      allPosts: allPosts ?? this.allPosts,
      allSignedInUserPosts: allSignedInUserPosts ?? this.allSignedInUserPosts,
    );
  }
}
