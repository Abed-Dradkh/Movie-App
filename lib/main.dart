import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/pages/home/setting_home.dart';
import 'package:flutter_application_2/pages/start.dart';
import 'package:flutter_application_2/services/theme_provider.dart';
import 'package:flutter_application_2/services/user_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId(oneSignlaId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, UserProvider>(
      builder: (_, theme, user, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.darkTheme
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          home: (user.userName.isEmpty && user.userPhotoUrl.isEmpty)
              ? const StartPage()
              : const SettingHome(),
        );
      },
    );
  }
}
