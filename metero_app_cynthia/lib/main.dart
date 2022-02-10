import 'package:flutter/material.dart';
import 'package:metero_app_cynthia/pages/city_days_page.dart';
import 'package:metero_app_cynthia/pages/current_day_page.dart';
import 'package:metero_app_cynthia/pages/home_page.dart';
import 'package:metero_app_cynthia/pages/map_page.dart';
import 'package:metero_app_cynthia/pages/utils/preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferenceUtils.init();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeteroApp',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/home': (context) => HomePage(),
        '/current_day': (context) => CurrentDayPage(),
        '/one_call': (context) => CityDaysPage()
      },
    );
  }
}
