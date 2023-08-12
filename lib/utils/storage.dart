import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static setAccessToken(String token) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("access_token", token);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("access_token");
  }

  static setUserInfo(String userInfo) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("user_info", userInfo);
  }

  static Future<String?> getUserInfo() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getString("user_info");
  }

  static clear() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();
    sharedPrefs.reload();
  }
}
