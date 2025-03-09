import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/config/plugins/shared_prefs_plugin.dart';

final isDarkModeProvider = StateProvider<bool>((ref) {
  final systemIsDark =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  return SharedPrefsPlugin.sharedPrefs?.getBool(isDarkTheme) ??
      systemIsDark == Brightness.dark;
});
