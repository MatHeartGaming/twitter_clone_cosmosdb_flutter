import 'package:flutter/material.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/widget_characteristics.dart';

class StackedIconsOnWidgets extends StatelessWidget {
  final Widget child;
  final VoidCallback onFirstIconTap;
  final IconData firstIcon;
  final Widget? otherWidgets;
  final Color? iconColor;

  const StackedIconsOnWidgets(
      {super.key,
      required this.child,
      required this.onFirstIconTap,
      required this.firstIcon,
      this.otherWidgets,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Widget Here
        child,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: onFirstIconTap,
                child: getCirclePictureStyledIcon(context, firstIcon)),
            otherWidgets ?? const SizedBox(),
          ],
        ),
      ],
    );
  }
}
