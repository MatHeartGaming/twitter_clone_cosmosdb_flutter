import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/circle_picture.dart';

class PostWidget extends ConsumerWidget {
  final Post post;

  const PostWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserPostRow(
            User.empty(
              dateCreated: DateTime.now(),
              username: 'MatBuompy',
              nome: 'Matteo',
              cognome: 'Buompastore',
            ),
          ),
          Text(post.body),
          if (post.isUrlImageValid)
            Visibility(
              visible: post.isUrlImageValid,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  fit: BoxFit.cover,
                  image: NetworkImage(post.urlImage!),
                ),
              ),
            ),
          _InteractionsRow(),
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
        CirclePicture(urlPicture: profilePic, minRadius: 10, maxRadius: 18),
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
  const _InteractionsRow();

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
          icon: Icon(FontAwesomeIcons.heart, color: Colors.grey, size: 15),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.chartSimple, color: Colors.grey, size: 15),
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
