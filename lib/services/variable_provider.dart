import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VariableProvider extends ChangeNotifier {
  int index = 1;
  bool flag = false;
  bool isPlaying = false;
  File imagePath = File('');

  changeIndex(int i) {
    index = i;
    notifyListeners();
  }

  changeFlag() {
    flag = !flag;
    notifyListeners();
  }

  switchIsPlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  Future pickImage(ImageSource source) async {
    try {
      final path = await ImagePicker().pickImage(source: source);
      if (path == null) return;
      imagePath = File(path.path);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
