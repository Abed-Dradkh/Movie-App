import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool darkTheme = false;

  ThemeProvider() {
    getTheme();
  }

  setdarktheme(bool value) {
    darkTheme = value;
    _setTheme(darkTheme);
    notifyListeners();
  }

  _setTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Theme', value);
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    darkTheme = prefs.getBool('Theme') ?? false;
    notifyListeners();
  }
}
