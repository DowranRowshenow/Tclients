import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<void> setToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    print("\nStorage Created Preferences");
  }

  Future<String> loadToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("\nStorage Loading Token");
    return sharedPreferences.getString('token') ?? "";
  }
}
