import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';

class SharedPrefsPlugin {
  static SharedPreferences? sharedPrefs;

  static Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  static void setDarkOrLightTheme(bool isDarkMode) {
    sharedPrefs?.setBool(isDarkTheme, isDarkMode);
  }
}
