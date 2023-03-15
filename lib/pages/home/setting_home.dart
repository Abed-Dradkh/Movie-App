import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/services/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingHome extends StatefulWidget {
  const SettingHome({Key? key}) : super(key: key);

  @override
  State<SettingHome> createState() => _HomeState();
}

class _HomeState extends State<SettingHome> {
  int currentIndex = 1; // initial index of bottom nav bar

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, __) {
        return Scaffold(
          bottomNavigationBar: CurvedNavigationBar( // Using Custom Nav Bar 
            items: navigateIcons,
            index: currentIndex,
            color: theme.darkTheme
                ? const Color.fromARGB(255, 42, 89, 126)
                : const Color.fromARGB(255, 163, 210, 247),
            backgroundColor: Colors.transparent,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
          ),
          body: pages[currentIndex],
        );
      },
    );
  }
}
