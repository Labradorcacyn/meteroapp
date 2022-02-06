import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metero_app_cynthia/pages/current_day_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    CurrentDayPage(),
    //CityDaysPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(FontAwesomeIcons.thermometerEmpty, size: 20),
      Icon(FontAwesomeIcons.calendarDay, size: 20)
    ];

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.purple.shade100,
          color: Colors.purple,
          index: 0,
          height: 60,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          items: items,
          onTap: (value) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
