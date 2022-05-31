import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/theme_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, __) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.075,
              vertical: MediaQuery.of(context).size.height * 0.15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 61,
                  backgroundColor: theme.darkTheme
                      ? Colors.green.withOpacity(0.5)
                      : Colors.blue.withOpacity(0.5),
                  child: CircleAvatar(
                    radius: 56,
                    backgroundColor: theme.darkTheme
                        ? const Color.fromARGB(255, 48, 48, 48)
                        : Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user.photoURL ?? ''),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    user.displayName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "PLayfair",
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
