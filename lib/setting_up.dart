import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/home/setting_home.dart';
import 'package:flutter_application_2/pages/login.dart';

class SettingUp extends StatelessWidget {
  const SettingUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Login();
        } else if (snapshot.hasData) {
          return const SettingHome();
        }
        return Login();
      }),
    );
  }
}
