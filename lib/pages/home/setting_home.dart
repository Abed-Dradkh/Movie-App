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
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, theme, __) {
        return Scaffold(
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.white.withOpacity(0.5),
            ),
            child: CurvedNavigationBar(
              color: theme.darkTheme
                  ? Colors.green.withOpacity(0.5)
                  : Colors.blue.withOpacity(0.5),
              backgroundColor: Colors.transparent,
              items: navigateIcons,
              index: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          body: pages[currentIndex],
        );
      },
    );
  }
}
