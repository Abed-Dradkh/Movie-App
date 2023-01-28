import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String userName = '';
  String userPhotoUrl = '';
  String defualtImage = 'assets/images/defualt_image.jpg';

  UserProvider() {
    getUserInfo();
  }

  setUserInfo(String name, String path) async {
    final shared = await SharedPreferences.getInstance();
    shared.setString('name', name);
    shared.setString('url', path);
    notifyListeners();
  }

  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    userName = prefs.getString('name') ?? '';
    userPhotoUrl = prefs.getString('url') ?? '';

    notifyListeners();
  }
}
