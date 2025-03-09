import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/config/plugins/shared_prefs_plugin.dart';
import 'package:twitter_cosmos_db/config/theme/app_theme.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';

// Un objeto de tipo AppTheme (custom). El que controla es ThemeNotifier, la instancia es de AppTheme.
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((
  ref,
) {
  final themeNotifier = ThemeNotifier();

  // Dark or light
  final isDarkMode = ref.watch(isDarkModeProvider);
  themeNotifier.setDarkMode(isDarkMode);

  return themeNotifier;
});

// Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void onAppPrimaryColorChanged(Color color) {
    state = state.copyWith(customColor: color);
  }

  void setDarkMode(bool isDark) {
    state = state.copyWith(isDarkMode: isDark);
    SharedPrefsPlugin.setDarkOrLightTheme(isDark);
  }

  bool toggleDarkmode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    setDarkMode(state.isDarkMode);
    return state.isDarkMode;
  }
}
