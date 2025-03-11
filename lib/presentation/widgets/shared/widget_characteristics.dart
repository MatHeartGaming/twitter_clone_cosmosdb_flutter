import 'package:flutter/material.dart';

Icon getCirclePictureStyledIcon(BuildContext context, IconData icon,
    {Color? iconColor, double iconSize = 35}) {
  final colors = Theme.of(context).colorScheme;
  return Icon(
    icon,
    color: iconColor ?? colors.onSurface.withValues(alpha:0.9),
    size: iconSize,
    shadows: [
      getIconShadow(context, iconColor: iconColor),
    ],
  );
}

BoxShadow getIconShadow(BuildContext context, {Color? iconColor}) {
  final colors = Theme.of(context).colorScheme;
  return BoxShadow(
    color: iconColor ?? colors.primary,
    blurRadius: 10,
    blurStyle: BlurStyle.normal,
    spreadRadius: 5,
  );
}
