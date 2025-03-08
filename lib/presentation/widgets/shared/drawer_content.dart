import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/circle_picture.dart';

class DrawerContent extends StatelessWidget {
  final User user;

  const DrawerContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CirclePicture(
                    urlPicture: profilePic,
                    minRadius: 20,
                    maxRadius: 20,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.gears),
                  ),
                ],
              ),

              Text(
                user.completeName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                user.username,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              Text(
                'drawer_following_count',
              ).tr(args: ['${user.followed.length}']),
            ],
          ),
        ),

        ..._getMenuItems().entries.map(
          (item) => ListTile(
            leading: Icon(item.value),
            title: Text(
              item.key,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Map<String, IconData> _getMenuItems() {
    return {
      'drawer_profile_item'.tr(): Icons.person,
      'drawer_premium_item'.tr(): FontAwesomeIcons.x,
      'drawer_saved_item'.tr(): FontAwesomeIcons.bookmark,
      'drawer_jobs_item'.tr(): Icons.wallet_travel,
      'drawer_lists_item'.tr(): Icons.list,
      'drawer_spaces_item'.tr(): Icons.space_dashboard,
      'drawer_monetization_item'.tr(): FontAwesomeIcons.moneyBill1Wave,
    };
  }
}
