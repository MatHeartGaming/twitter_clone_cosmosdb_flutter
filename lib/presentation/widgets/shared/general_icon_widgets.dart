
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget showHidePasswordIcon(bool showPassword) {
    return Stack(
      children: [
        Icon(showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
      ],
    );
  }