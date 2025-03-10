import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
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
              data:
                  (user) => _UserPostRow(
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
              liked: signedInUser?.postLiked.contains(post.id) ?? false,
            ),
          ],
        ),
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
  final VoidCallback onLikeTapped;

  const _InteractionsRow({required this.onLikeTapped, this.liked = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(FontAwesomeIcons.comment, color: Colors.grey, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.retweet, color: Colors.grey, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon:
              liked
                  ? BounceIn(
                    child: Icon(FontAwesomeIcons.solidHeart, color: Colors.red),
                  )
                  : Icon(FontAwesomeIcons.heart, color: Colors.grey, size: 15),
          onPressed: onLikeTapped,
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
