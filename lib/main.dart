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
  await Firebase.initializeApp();
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
    print(defualt_value); // defualt limitation for reqeust 
    super.initState();
    //OneSignal Services
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId(oneSignlaId);
    
    //Firebase Remote Config
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      setState(() {
        defualt_value = remoteConfig.getInt('Limitation');
      });
    });
    print(defualt_value);// defualt limitation for reqeust after fetching data from firebase Using Firebase Remote Config
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, UserProvider>(
      builder: (_, theme, user, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme.darkTheme //Changing theme between dark and light
              ? ThemeData.dark(useMaterial3: true)
              : ThemeData.light(useMaterial3: true),
          home: (user.userName.isEmpty && user.userPhotoUrl.isEmpty) //Checking user name and photo
              ? const StartPage()
              : const SettingHome(),
        );
      },
    );
  }
}
