import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';

void popScreen(BuildContext context) {
  if (!context.mounted) return;
  context.pop();
}

void appHeaderNavigation(BuildContext context, String path) {
  if (!context.mounted) return;
  context.push('/$path');
}

void pushToLoginSignupScreen(BuildContext context) {
  if (!context.mounted) return;
  context.push(loginPath);
}