
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Widget addPostFab({required VoidCallback onPressed}) {
    return BounceIn(
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.add),
        color: Colors.white,
        style: const ButtonStyle().copyWith(
          backgroundColor: WidgetStatePropertyAll(Colors.blue),
          minimumSize: WidgetStatePropertyAll(Size(50, 50)),
        ),
      ),
    );
  }