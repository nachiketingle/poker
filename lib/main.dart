import 'package:flutter/material.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/chips_page.dart';
import 'package:poker/Pages/ChipsPage/Setup/setup_page.dart';

import 'Pages/menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Menu(),
        '/localSetup': (context) => SetupPage(),
        '/localTracker': (context) => ChipsPage(),
      },
    );
  }
}

