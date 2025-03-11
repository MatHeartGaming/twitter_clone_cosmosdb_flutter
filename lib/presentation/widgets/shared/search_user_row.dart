import 'package:flutter/material.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class SearchUserRow extends StatelessWidget {
  final User user;

  const SearchUserRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      CirclePicture(
        urlPicture: user.profileImageUrl,
        height: 50,
        width: 50,
      ),
      Text(user.completeName, style: TextStyle(fontWeight: FontWeight.bold),),
      Text('@${user.username}'),
    ]);
  }
}
