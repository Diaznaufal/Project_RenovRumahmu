import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String walkthroughKey = "walkthrough_seen";
  static const String loginKey = "is_logged_in";

  // Walkthrough
  Future<void> setWalkthroughSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(walkthroughKey, true);
  }

  Future<bool> isWalkthroughSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(walkthroughKey) ?? false;
  }

  // Login
  Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginKey, value);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginKey) ?? false;
  }
}
