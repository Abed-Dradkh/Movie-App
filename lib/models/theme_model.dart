import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel {
  setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Theme', value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('Theme') ?? false;
  }
}
