import 'package:flutter/cupertino.dart';

class VariableProvider extends ChangeNotifier {
  bool flag = false;
  bool fav = false;

  changeFlag() {
    flag = !flag;
    notifyListeners();
  }

  switchFav() {
    fav = !fav;
    notifyListeners();
  }
}
