import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/bookmark.dart';
import 'package:flutter_application_2/pages/explore.dart';
import 'package:flutter_application_2/pages/home/home.dart';
import 'package:flutter_application_2/pages/options.dart';
import 'package:flutter_application_2/pages/profile.dart';

String userName = '';
String movieApi = '8b32e84f3944490ea342f6d527412f85';
List<String> imdbApiKeys = [
  'k_2uux5jyk',
  'k_nz4mczju',
  'k_r11bajw5',
  'k_6sxv7x1o'
];
List<TextEditingController> controllers = [
  for (int i = 0; i < 5; i++) TextEditingController()
];

var navigateIcons = const [
  Icon(Icons.explore_rounded, size: 30),
  Icon(Icons.bookmark_rounded, size: 30),
  Icon(Icons.home, size: 30),
  Icon(Icons.person_rounded, size: 30),
  Icon(Icons.settings_rounded, size: 30)
];

var pages = [
  const Explore(),
  const BookMark(),
  Home(),
  Profile(),
  const Options(),
];

var scoresText = [
  'IMDb',
  'Rotten_Tomatoes',
  'Metacritic',
  'MovieDb',
  'Filmaffinity',
];

var colors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
  Colors.green,
  Colors.orange
];
