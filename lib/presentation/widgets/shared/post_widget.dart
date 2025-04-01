import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/providers/posts_repository/comments_repository.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/circle_picture.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/loading_default_widget.dart';

class PostWidget extends ConsumerWidget {
  final Post post;
  final VoidCallback onLikeTapped;
  final VoidCallback onImageTapped;

  const PostWidget({
    super.key,
    required this.post,
    required this.onLikeTapped,
    required this.onImageTapped,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(getUserByIdFutureProvider(post.userId));
    final signedInUser = ref.watch(signedInUserProvider);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userAsync.when(
              data: (user) => _UserPostRow(
                user ?? User.empty(dateCreated: DateTime.now()),
              ),
              loading: () => LoadingDefaultWidget(),
              error: (error, stackTrace) => Text(error.toString()),
            ),
            Text(post.body),
            if (post.isUrlImageValid)
              Visibility(
                visible: post.isUrlImageValid,
                child: GestureDetector(
                  onTap: onImageTapped,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                      image: NetworkImage(post.urlImage!),
                    ),
                  ),
                ),
              ),
            _InteractionsRow(
              onLikeTapped: onLikeTapped,
              likeNumber: post.likes.length,
              liked: post.likes.contains(signedInUser?.username) ||
                  post.likes.contains(signedInUser?.id),
              commentNumber: post.comments.length,
              onCommentTapped: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled:
                      true, // Allows the modal to take up more space
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return SafeArea(
                      minimum: const EdgeInsets.only(top: 30),
                      child: _CommentsModal(
                        post: post,
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentsModal extends ConsumerWidget {
  final Post post;

  const _CommentsModal({
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = TextEditingController();
    final comments = ref.watch(commentsProvider(post.comments));
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Modal Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'comments_screen_title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ).tr(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const Divider(),
          // Display Comments
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.comment, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(child: Text(comment)),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(),
          // Add a Comment
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'comments_screen_add_comment_hint'.tr(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                  final newComment = commentController.text.trim();
                  if (newComment.isNotEmpty) {
                    // Update the post with the new comment
                    final updatedComments = [...post.comments, newComment];
                    final updatedPost =
                        post.copyWith(comments: updatedComments);
                    ref
                        .read(commentsProvider(post.comments).notifier)
                        .update((state) => updatedComments);

                    // Save the updated post to the database
                    await ref
                        .read(postsRepositoryProvider)
                        .updatePost(updatedPost);

                    // Clear the text field
                    commentController.clear();

                    final loadPosts = ref.read(loadPostsProvider.notifier);
                    loadPosts.fetchAllPosts();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserPostRow extends StatelessWidget {
  final User user;

  const _UserPostRow(this.user);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CirclePicture(
          urlPicture: user.profileImageUrl,
          minRadius: 10,
          maxRadius: 18,
        ),
        SizedBox(width: 10),
        Text(user.completeName, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(width: 5),
        Text(
          '@${user.username}',
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
        ),
      ],
    );
  }
}

class _InteractionsRow extends StatelessWidget {
  final bool liked;
  final int likeNumber;
  final int commentNumber;
  final VoidCallback onLikeTapped;
  final VoidCallback onCommentTapped; // Add this callback

  const _InteractionsRow({
    required this.onLikeTapped,
    required this.onCommentTapped, // Add this parameter
    this.likeNumber = 0,
    this.commentNumber = 0,
    this.liked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton(
              icon:
                  Icon(FontAwesomeIcons.comment, color: Colors.grey, size: 15),
              onPressed: onCommentTapped, // Trigger the callback
            ),
            Text(
              '$commentNumber',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.retweet, color: Colors.grey, size: 15),
          onPressed: () {},
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: liked
                  ? BounceIn(
                      child:
                          Icon(FontAwesomeIcons.solidHeart, color: Colors.red),
                    )
                  : Icon(FontAwesomeIcons.heart, color: Colors.grey, size: 15),
              onPressed: onLikeTapped,
            ),
            Text('$likeNumber',
                style: TextStyle(
                  fontSize: 12,
                  color: liked ? Colors.red : Colors.grey,
                )),
          ],
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.chartSimple,
            color: Colors.grey,
            size: 15,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.bookmark, color: Colors.grey, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.share, color: Colors.grey, size: 15),
          onPressed: () {},
        ),
      ],
    );
  }
}
