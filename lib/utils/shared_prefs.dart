import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String keySeenGetStarted = 'seen_get_started';
  static const String keyIsLoggedIn = 'is_logged_in';

  static Future<void> setSeenGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keySeenGetStarted, true);
  }

  static Future<bool> hasSeenGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keySeenGetStarted) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}