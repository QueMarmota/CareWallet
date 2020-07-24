import 'package:carewallet/home_screen.dart';
import 'package:carewallet/sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'fl_chart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Initialize prefs in the main level always
  final prefs = new MiSharedPreferences();
  await prefs.initprefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: HomeScreen());
  }
}
