import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/explore.dart';
import 'package:flutter_application_2/pages/home/home.dart';
import 'package:flutter_application_2/pages/profile.dart';
import 'package:flutter_application_2/services/movie_provider.dart';
import 'package:flutter_application_2/services/theme_provider.dart';
import 'package:flutter_application_2/services/user_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

String movieApi = '8b32e84f3944490ea342f6d527412f85';
String oneSignlaId = 'baca465f-2938-4761-a21a-c97b38b26176';

String font = 'NerkoOne';

final dio = Dio();
final formKey = GlobalKey<FormState>();
final scrollController1 = ScrollController();
final scrollController2 = ScrollController();
List<TextEditingController> controllers = [
  for (int i = 0; i < 5; i++) TextEditingController()
];

var navigateIcons = const [
  Icon(Icons.explore_rounded),
  Icon(Icons.home),
  Icon(Icons.person_rounded),
];

var pages = [
  const Explore(),
  const Home(),
  const Profile(),
];

var colors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.orange
];

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => MovieProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => VariableProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
  ),
  ChangeNotifierProvider(
    create: (context) => UserProvider(),
  ),
];

List<int> pageNumbers = [for (int i = 1; i <= 15; i++) i];
