import 'package:flutter/cupertino.dart';
import 'package:flutter_application_2/models/theme_model.dart';

class ThemeProvider with ChangeNotifier {
  ThemeModel themeModel = ThemeModel();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value){
    _darkTheme=value;
    themeModel.setTheme(value);
    notifyListeners();
  }
}
