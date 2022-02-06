import 'package:flutter/material.dart';
import 'package:metero_app_cynthia/pages/current_day_page.dart';
import 'package:metero_app_cynthia/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeteroApp',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}
