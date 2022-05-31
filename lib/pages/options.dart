import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/theme_provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: ((_, theme, __) {
        return Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Theme Mode:'),
              FlutterSwitch(
                showOnOff: true,
                activeText: 'Light',
                inactiveText: 'Dark',
                width: MediaQuery.of(context).size.width * 0.21,
                
                activeIcon: const Icon(
                  Icons.nightlight_rounded,
                  color: Colors.black,
                ),
                inactiveIcon: const Icon(
                  Icons.wb_sunny_rounded,
                  color: Colors.amber,
                ),
                value: theme.darkTheme,
                onToggle: (value) {
                  theme.darkTheme = !theme.darkTheme;
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
