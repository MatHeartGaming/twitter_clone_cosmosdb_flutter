import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/navigation/navigation_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/circle_picture.dart';

class DrawerContent extends ConsumerWidget {
  final User user;

  const DrawerContent({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedInUser = ref.watch(signedInUserProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          signedInUser == null
              ? SafeArea(
                child: ZoomIn(
                  child: TextButton(
                    onPressed: () => pushToLoginSignupScreen(context),
                    child: Text('login_text').tr(),
                  ),
                ),
              )
              : DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CirclePicture(
                          urlPicture:
                              user.isProfileUrlValid
                                  ? user.profileImageUrl
                                  : '',
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
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'drawer_following_count',
                    ).tr(args: ['${user.followed.length}']),
                  ],
                ),
              ),

          // Expanding the list of menu items to push the toggle button to the bottom
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children:
                  _getMenuItems().entries
                      .map(
                        (item) => SlideInLeft(
                          child: ListTile(
                            leading: Icon(item.value),
                            title: Text(
                              item.key,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),

          // Align the toggle button at the bottom left
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () {
                  final isDark =
                      ref.read(themeNotifierProvider.notifier).toggleDarkmode();
                  ref
                      .read(isDarkModeProvider.notifier)
                      .update((state) => isDark);
                },
                icon:
                    isDarkMode
                        ? FadeIn(child: Icon(Icons.light_mode))
                        : FadeIn(child: Icon(Icons.dark_mode)),
              ),
            ),
          ),
        ],
      ),
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
