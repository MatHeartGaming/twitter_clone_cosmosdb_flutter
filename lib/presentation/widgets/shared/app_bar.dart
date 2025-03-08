import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/circle_picture.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback? onProfileIconPressed;

  const HomeAppBar({super.key, this.onProfileIconPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onProfileIconPressed,
          child: CirclePicture(
            urlPicture: profilePic,
            minRadius: 10,
            maxRadius: 15,
          ),
        ),
        Icon(FontAwesomeIcons.twitter),
        Icon(FontAwesomeIcons.gear),
      ],
    );
  }
}
