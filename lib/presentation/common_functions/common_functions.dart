import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';

void onLikeTappedAction(Post post, WidgetRef ref) {
  final likedPostsId = post.id;
  final userNotifier = ref.read(loadUsersProvider.notifier);
  final postsNotifier = ref.read(loadPostsProvider.notifier);
  final signedInUser = ref.read(signedInUserProvider);

  if (signedInUser == null) return;

  List<String> updatedLikes = List<String>.from(post.likes);

  if (updatedLikes.contains(signedInUser.username)) {
    updatedLikes.remove(signedInUser.username);
  } else {
    updatedLikes.add(signedInUser.username);
  }

  List<String> newPostLikedList = List<String>.from(signedInUser.postLiked);

  if (newPostLikedList.contains(likedPostsId)) {
    newPostLikedList.remove(likedPostsId);
  } else {
    newPostLikedList.add(likedPostsId);
  }

  userNotifier.updateUser(signedInUser.copyWith(postLiked: newPostLikedList));
  postsNotifier.updatePost(post.copyWith(likes: updatedLikes));

  ref.read(signedInUserProvider.notifier).state = signedInUser.copyWith(
    postLiked: newPostLikedList,
  );
}

void onImageTapped(BuildContext context, String imageUrl) {
  final imageProvider = Image.network(imageUrl).image;
  showImageViewer(
    context,
    imageProvider,
    swipeDismissible: true,
    useSafeArea: true,
    onViewerDismissed: () {
      logger.i("dismissed");
    },
  );
}
